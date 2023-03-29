import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../../data/constant.dart';
import '../../../helpers/database.dart';
import '../../../providers/data_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../services/objectif_service.dart';
import '../../../services/token_service.dart';
import '../../../widgets/status_response.dart';

class HomeController extends GetxController {

  DataProvider dataProvider = Get.put(DataProvider());

  TokenService tokenService = Get.find<TokenService>();
  ObjectifService objectifService = Get.find<ObjectifService>();

  TextEditingController identifiant = TextEditingController();

  ProgressDialog? progressDialog;

  @override
  void onInit() {
    super.onInit();
    progressDialog = ProgressDialog(context: Get.context);
    objectifService.getData();
    objectifService.getObjR();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  RxBool isScanning = false.obs;
  scanBarcode() async {
    isScanning.value = true;
    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666",
          "Retour",
          true,
          ScanMode.BARCODE
      );

      log("result ==================> $result");

      Future.delayed(Duration(seconds: 2), (){
        if(result != '-1'){
          identifiant.text = result.substring(3);
          Get.back();
          searchCompteur();
        }
        isScanning.value = false;
      });

    } on PlatformException {
      Get.snackbar("Platform error",
          "Failed to get platform version",
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }


  RxBool searchLoad = false.obs;
  searchCompteur() async {
    searchLoad.value = true;
    if(identifiant.text.trim() != ""){
      try {
        final response = await dataProvider.searchCompteur(identifiant.text);
        searchLoad.value = false;
        if(response['hasError']){
          statusResponseSearch(
              DialogType.error, "Erreur",
              response['status']['message'],
            param: identifiant.text,
            status: false
          );
        } else {
          statusResponseSearch(
              DialogType.success, "Succès",
              "${response['status']['message']}",
          );
        }
        log("response ==========> ${response}");
      } catch(e){
        searchLoad.value = false;
        Fluttertoast.showToast(
          msg: "Une erreur est survenue, veuillez réessayer",
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red
        );
        print("erreur =========> $e");
      }
      var realises = await objectifService.getObjR();
      await objectifService.setObjR(realises++);
      //save objectif
    }
    identifiant.clear();
  }


  logout() {
    Get.defaultDialog(
        title: "Déconnexion",
        titleStyle: TextStyle(
            color: Colors.red, fontSize: 18, fontWeight: FontWeight.w700),
        barrierDismissible: false,
        textCancel: "Non",
        textConfirm: "Oui",
        middleText: "Souhaitez-vous fermer votre session ?",
        radius: 10,
        cancelTextColor: Colors.red,
        confirmTextColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        buttonColor: Colors.red,
        onConfirm: () {
          tokenService.removeToken();
          Get.offAllNamed(Routes.LOGIN);
          //snackbar(primaryColor, "Deconnecté", "Vous êtes deconnecté");
        });
  }


  List errorList = [];
  RxBool process = false.obs;
  RxBool showResult = RxBool(false);
  RxInt index = 0.obs;

  syncData() async {
    errorList = [];
    List _data = await DatabaseHelper.instance.queryAllNotSynchronized();

    if(_data.length > 0){
      progressDialog!.show(
          max: _data.length,
          msg: "Preparation de la synchronisation",
          progressType: ProgressType.valuable,
          progressValueColor: primaryColor,
          progressBgColor: Colors.grey.shade200,
          msgFontSize: 14,
          valueFontSize: 13
      );

      for(int i = 0; i < _data.length; i++){
        progressDialog!.update(value: i + 1, msg: "Synchronisation en cours ...");
        final item = _data[i];
        log("item =================> ${item}");
        try {
          await dataProvider.postNewCpt(jsonDecode(item['data']));
          await DatabaseHelper.instance.remove(item['id']);

        } catch (e){
          print("catch =======================================> sync data ${e}");
          errorList.add(item);
        }
      }

      progressDialog!.close();

      statusResponse(
          errorList.length == 0 ? DialogType.success : DialogType.warning,
          "Synchronisation",
          "${_data.length - errorList.length}/${_data.length} synchronisées", duration: 3500);
    } else {
      Fluttertoast.showToast(
          msg: "Auncue donnée a synchroniser",
        backgroundColor: primaryColor,
        timeInSecForIosWeb: 3
      );
    }
  }


}
