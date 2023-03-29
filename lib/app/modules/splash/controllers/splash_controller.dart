import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/objectif_service.dart';
import '../../../services/token_service.dart';

class SplashController extends GetxController {
  TokenService tokenService = Get.put(TokenService());
  ObjectifService objectifService = Get.put(ObjectifService());

  @override
  void onInit() {
    redirect();
    super.onInit();
    
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  redirect() {
    Future.delayed(Duration(seconds: 3), () {
      //Get.offNamed(tokenService.getToken() == null ? Routes.LOGIN : Routes.HOME);
      Get.offNamed(Routes.HOME);
    });
  }
}
