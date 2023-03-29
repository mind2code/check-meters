import 'package:flutter/material.dart';

import 'package:get/get.dart';
import "package:hexcolor/hexcolor.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:metters_check/app/utils/screen_util.dart';

import '../../../data/constant.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            //padding: EdgeInsets.only(top: 80),
            child: SafeArea(
              child: Column(children: [
                Expanded(
                  child: Container(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FractionallySizedBox(
                          heightFactor: .45,
                          widthFactor: .5,
                          child: Image.asset(
                            "assets/Logo_CIE.png",
                          ),
                        ),
                        FractionallySizedBox(
                          heightFactor: .5,
                          widthFactor: .53,
                          child: Container(
                            // color: Colors.black26,
                            child: Stack(
                              children: [
                                Positioned(
                                  height: 15,
                                  width: 15,
                                  left: 20,
                                  bottom: 45,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor("#f37735")
                                            .withOpacity(.6)),
                                  ),
                                ),
                                Positioned(
                                  height: 10,
                                  width: 10,
                                  right: 45,
                                  top: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor("#f37735")
                                            .withOpacity(.6)),
                                  ),
                                ),
                                Positioned(
                                  height: 25,
                                  width: 25,
                                  right: 10,
                                  bottom: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: HexColor("#f37735")
                                            .withOpacity(.6)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: SWS.width(15)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Bienvenue dans",
                              style: TextStyle(
                                  fontSize: SWS.fontSize(18),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' Meters',
                              style: TextStyle(
                                  fontSize: SWS.fontSize(22),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " Checker",
                              style: TextStyle(
                                  fontSize: SWS.fontSize(22),
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Keep your data safe",
                          style:
                          TextStyle(fontSize: SWS.fontSize(12), color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              myTextfield(
                                  "Nom d'utilisateur", controller.username),
                              SizedBox(
                                height: SWS.height(15),
                              ),
                              myTextfield("Mot de passe", controller.password,
                                  obscur: !controller.obscur.value,
                                  suffix: true,
                                  func: controller.toogleObscure),
                            ],
                          )
                        ),
                        SizedBox(
                          height: SWS.height(15),
                        ),
                        Text(
                          controller.message.isEmpty
                              ? ''
                              : controller.message.value,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: SWS.height(25),
                        ),
                        InkWell(
                          onTap:
                            controller.loading.value
                              ? null
                              : () {
                            if(controller.formKey.currentState!.validate()){
                              controller.login();
                            }
                          },
                          child: Container(
                            height: SWS.height(50),
                            width: Get.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: controller.loading.value
                                    ? Colors.orange.shade300
                                    : HexColor("#f37735"),
                                borderRadius: BorderRadius.circular(8)),
                            child: controller.loading.value
                                ? SpinKitFadingCircle(
                              color: Colors.white,
                              size: SWS.fontSize(25),
                            )
                                : Text(
                              'Se connecter',
                              style: TextStyle(
                                fontSize: SWS.fontSize(14),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SWS.height(20),
                        ),
                        Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                              color: HexColor("#f37735"),
                              fontSize: SWS.fontSize(14),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  flex: 2,
                )
              ]),
            ),
          ),
        ))
    );
  }
}

Widget myTextfield(String label, TextEditingController controller,
    {bool obscur = false, bool suffix = false, Function()? func}) {
  return Container(
    width: Get.width,
    height: SWS.height(52),
    padding: EdgeInsets.symmetric(horizontal: SWS.width(15)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: HexColor("f6f6f6")),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscur,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                    fontSize: SWS.fontSize(13),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
                border: InputBorder.none),
          ),
        ),
        suffix
            ? InkWell(
            onTap: func!,
            child: Icon(obscur
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined, size: SWS.fontSize(23),))
            : Row()
      ],
    ),
  );
}