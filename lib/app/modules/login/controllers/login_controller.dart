import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/auth_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../services/token_service.dart';

class LoginController extends GetxController {

  AuthProvider authProvider = Get.put(AuthProvider());

  TokenService tokenService = Get.find<TokenService>();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();


  RxString message = ''.obs;
  RxBool loading = false.obs;
  RxBool obscur = false.obs;

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


  login() async {
    loading.value = true;
    message.value = "";

    if(username.text.trim() != "" && password.text.trim() != ""){
      try {
        final response = await authProvider.login(username.text, password.text);
        final decoded = jsonDecode(response);
        tokenService.setToken(decoded['access_token']);
        tokenService.getToken();
        Get.offAllNamed(Routes.HOME);

      } catch (e){
        message.value = e.toString();
        print("error ======================> $e");
      }
    } else {
      message.value = "Veuillez renseigner vos identifiants";
    }

    loading.value = false;

  }

  toogleObscure() {
    obscur.toggle();
  }
}
