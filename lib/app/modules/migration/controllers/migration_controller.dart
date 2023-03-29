import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:metters_check/app/providers/data_provider.dart';

class MigrationController extends GetxController {

  TextEditingController compteur = TextEditingController();

  RxString compteurVersion = "".obs;
  RxString token1 = "".obs;
  RxString token2 = "".obs;

  DataProvider dataProvider = Get.put(DataProvider());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}


  RxBool isLoading = false.obs;
  getToken() async {
    isLoading.value = true;
    try {
      final response = await dataProvider.getToken(compteur.text);

      if(response['state'] == 0){
        compteurVersion.value = response['baseTime'] ?? "";
        token1.value = response['token'].toString().split(",")[0].replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
        token2.value = response['token'].toString().split(",")[1].replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");

      } else {
        Fluttertoast.showToast(msg: "Une erreur est survenue, impossible de générer le token",
          backgroundColor: Colors.red
        );
      }
    } catch (e){
      Fluttertoast.showToast(msg: "Une erreur est survenue",
          backgroundColor: Colors.red
      );
    }

    isLoading.value = false;

  }


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

      Future.delayed(Duration(seconds: 2), (){
        if(result != '-1'){
          compteur.text = result.substring(3);
          Get.back();
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

}
