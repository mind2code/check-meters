
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:metters_check/app/utils/screen_util.dart';

import '../../../data/constant.dart';
import '../../../widgets/customFormField.dart';
import '../controllers/migration_controller.dart';

class MigrationView extends GetView<MigrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: controller.isLoading.value ? null : controller.getToken,
        child: Obx(()=> Container(
          height: 45,
          width: Get.width * .8,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10)
          ),
          alignment: Alignment.center,
          child: controller.isLoading.value ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ) : Text("Obtenir les jetons", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
        )),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Migration'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Obx(()=> Container(
        padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15
        ),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomFormField(
                        controller: controller.compteur,
                        type: TextInputType.number,
                        lab: "Compteur",
                        onChanged: (s){},
                        readOnly: false,
                        inputFormatters: [
                        ],
                        validator: (s){
                          if(!s.isNotNull){
                            return "Veuillez entrer le numero du compteur";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: controller.scanBarcode,
                      child: Container(
                        height: SWS.height(45),
                        width: SWS.height(45),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(Icons.qr_code_scanner, color: Colors.white,),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25,),
                Text("Informations supplémentaires", style: TextStyle(
                    fontSize: SWS.fontSize(20),
                    fontWeight: FontWeight.bold
                )),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10
                  ),
                  width: Get.width,
                  //height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: primaryColor.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Version du compteur ", style: TextStyle(
                                  fontSize: SWS.fontSize(17),
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: 3,),
                              Image.asset("assets/meter.png", height: SWS.fontSize(15),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10
                            ),
                            height: SWS.height(35),
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: Text("${controller.compteurVersion.value}", style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: SWS.fontSize(14)
                            ),),
                          )
                        ],
                      ),
                      SizedBox(height: 25,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Token 1", style: TextStyle(
                                  fontSize: SWS.fontSize(17),
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: 3,),
                              Image.asset("assets/token.png", height: SWS.fontSize(15),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10
                            ),
                            alignment: Alignment.centerLeft,
                            height: SWS.height(35),
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(controller.token1.value, style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SWS.fontSize(14)
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Token 2", style: TextStyle(
                                  fontSize: SWS.fontSize(17),
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: 3,),
                              Image.asset("assets/token.png", height: SWS.fontSize(15),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10
                            ),
                            alignment: Alignment.centerLeft,
                            height: SWS.height(35),
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text("${controller.token2.value}", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SWS.fontSize(14)
                            ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      ))
    );
  }
}
