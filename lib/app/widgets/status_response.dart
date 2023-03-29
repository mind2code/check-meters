

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

statusResponse(DialogType dialogType, String title, String desc,
    {int duration = 2500}){
  AwesomeDialog(
    context: Get.context!,
    dialogType: dialogType,
    headerAnimationLoop: true,
    animType: AnimType.rightSlide,
    titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600
    ),
    descTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600
    ),
    title: title,
    desc: desc,
    showCloseIcon: true,
    autoHide: Duration(milliseconds: duration),
    width: Get.width,
    btnCancelText: "Fermer",
    dismissOnBackKeyPress: false

  ).show();
}

statusResponseSearch(DialogType dialogType, String title, String desc,
    {int duration = 2500, bool status = true, String? param}){
  AwesomeDialog(
      context: Get.context!,
      dialogType: dialogType,
      headerAnimationLoop: true,
      animType: AnimType.rightSlide,
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600
      ),
      descTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600
      ),
      title: title,
      desc: desc,
      showCloseIcon: true,
      //autoHide: Duration(milliseconds: duration),
      width: Get.width,
      dismissOnBackKeyPress: false,
    btnCancelText: status ? "Fermer" : "",
    btnCancelColor: status ? Colors.orange : Colors.transparent ,
    btnCancelOnPress: status ? (){} : null,
    btnOkText: !status ? "Enregistrer" : "Migrer",
    btnOkColor: !status ? Colors.orange : Colors.green ,
    btnOkOnPress: !status ? (){
        Get.toNamed(Routes.REGISTER, arguments: {"param": param });
    } : () async {
       // Get.toNamed(Routes.MIGRATION);
      await LaunchApp.openApp(
        androidPackageName: "com.inhe.stskeychange",
        openStore: false
      );
    },

  ).show();
}