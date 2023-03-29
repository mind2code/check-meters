import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:metters_check/app/utils/screen_util.dart';

import '../../../data/constant.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //    controller.objectifService.setObj(0);
      //   },
      // ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Accueil', style: TextStyle(
          color: Colors.black,
          fontSize: SWS.fontSize(20),
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.person, color: Colors.black,)
        ),
        actions: [
          IconButton(
              onPressed: controller.logout,
              icon: Icon(Icons.exit_to_app, color: Colors.black,)
          )
        ],
      ),
      body: Obx(() => Stack(
        children: [
          Container(

            padding: EdgeInsets.symmetric(
                horizontal: SWS.width(15)
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SWS.height(30),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bonjour,", style: TextStyle(
                          fontSize: SWS.fontSize(30),
                          fontWeight: FontWeight.w900
                      ),),
                      SizedBox(height: SWS.height(5),),
                      Text("${controller.tokenService.user.value.givenName} ${controller.tokenService.user.value.familyName}".capitalize!, style: TextStyle(
                          fontSize: SWS.fontSize(30),
                          fontWeight: FontWeight.w900
                      ),),
                    ],
                  ),
                  SizedBox(height: SWS.height(30),),
                  Column(
                    children: [
                      // homeContainer2("loupe.png", controller.searchLoad.value ? () => Fluttertoast.showToast(
                      //     msg: "Une recherche est déjà en cours, veuillez patienter",
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white
                      // ) : (){
                      //   Get.defaultDialog(
                      //       barrierDismissible: false,
                      //       radius: 7,
                      //       title: "Rechercher",
                      //       contentPadding: EdgeInsets.only(
                      //           top: 10,
                      //           left: 10,
                      //           right: 10
                      //       ),
                      //       content: Container(
                      //         height: 120,
                      //         width: Get.width * .8,
                      //         child: Column(
                      //           children: [
                      //             TextFormField(
                      //               controller: controller.identifiant,
                      //               keyboardType: TextInputType.number,
                      //               style: TextStyle(
                      //                 fontSize: 13,
                      //                 //fontWeight: FontWeight.bold
                      //               ),
                      //               decoration: InputDecoration(
                      //                   labelText: "Numéro",
                      //                   hintText: "Veuillez saisir le numéro du compteur",
                      //                   contentPadding: EdgeInsets.only(top: 5, left: 15),
                      //                   hintStyle: TextStyle(
                      //                       fontSize: 13,
                      //                       color: Colors.grey.shade400
                      //                   ),
                      //                   labelStyle: TextStyle(
                      //                       fontSize: 13,
                      //                       color: Colors.black
                      //                   ),
                      //                   focusedBorder: OutlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: primaryColor
                      //                       )
                      //                   ),
                      //                   enabledBorder: OutlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                         color: Colors.grey,
                      //                       ),
                      //                       borderRadius: BorderRadius.circular(7)
                      //                   ),
                      //                   errorMaxLines: 1,
                      //                   errorBorder: OutlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: Colors.red
                      //                       ),
                      //                       borderRadius: BorderRadius.circular(7)
                      //                   ),
                      //                   border: OutlineInputBorder(
                      //                       borderSide: BorderSide(
                      //                           color: Colors.black
                      //                       ),
                      //                       borderRadius: BorderRadius.circular(3)
                      //                   )
                      //               ),
                      //             ),
                      //             SizedBox(height: 10,),
                      //             Row(
                      //               //mainAxisAlignment: MainAxisAlignment.end,
                      //               children: [
                      //                 TextButton(
                      //                     onPressed: Get.back,
                      //                     child: Text("Fermer")),
                      //                 Spacer(),
                      //                 TextButton(
                      //                     onPressed: (){
                      //                       if(controller.identifiant.text.trim() != ""){
                      //                         Get.back();
                      //                         controller.searchCompteur();
                      //                       }
                      //                     },
                      //                     child: Text("Vérifier", style: TextStyle(
                      //                         color: primaryColor,
                      //                         fontWeight: FontWeight.bold
                      //                     ),))
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //   );
                      // }, controller.searchLoad.value ? () => Fluttertoast.showToast(
                      //     msg: "Une recherche est déjà en cours, veuillez patienter",
                      //     backgroundColor: Colors.red,
                      //     textColor: Colors.white
                      // ) : controller.scanBarcode),
                      SizedBox(height: 20,),
                      InkWell(
                          onTap: controller.searchLoad.value ? () => Fluttertoast.showToast(
                              msg: "Une recherche est déjà en cours, veuillez patienter",
                              backgroundColor: Colors.red,
                              textColor: Colors.white
                          ) : (){
                            Get.defaultDialog(
                                barrierDismissible: false,
                                radius: 7,
                                title: "Rechercher",
                                contentPadding: EdgeInsets.only(
                                    top: 10,
                                    left: 10,
                                    right: 10
                                ),
                                content: Container(
                                  height: 120,
                                  width: Get.width * .8,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: controller.identifiant,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 13,
                                          //fontWeight: FontWeight.bold
                                        ),
                                        decoration: InputDecoration(
                                            labelText: "Numéro",
                                            hintText: "Veuillez saisir le numéro du compteur",
                                            contentPadding: EdgeInsets.only(top: 5, left: 15),
                                            hintStyle: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade400
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: primaryColor
                                                )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.circular(7)
                                            ),
                                            errorMaxLines: 1,
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red
                                                ),
                                                borderRadius: BorderRadius.circular(7)
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black
                                                ),
                                                borderRadius: BorderRadius.circular(3)
                                            )
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: Get.back,
                                              child: Text("Fermer")),
                                          Spacer(),
                                          TextButton(
                                              onPressed: (){
                                                if(controller.identifiant.text.trim() != ""){
                                                  Get.back();
                                                  controller.searchCompteur();
                                                }
                                              },
                                              child: Text("Vérifier", style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold
                                              ),))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            );
                          },
                          child: homeContainer("loupe.png", "Numéro compteur", "Rechercher un compteur en renseignant le numéro")),
                      SizedBox(height: 20,),
                      InkWell(
                          onTap: controller.searchLoad.value ? () => Fluttertoast.showToast(
                              msg: "Une recherche est déjà en cours, veuillez patienter",
                              backgroundColor: Colors.red,
                              textColor: Colors.white
                          ) : controller.scanBarcode,
                          child: homeContainer("qr-code.png", "Scanner", "Rechercher un compteur en scannant le code barre")),


                      // SizedBox(height: SWS.height(15),),
                      // InkWell(
                      //     onTap: (){
                      //       Get.toNamed(Routes.MIGRATION);
                      //     },
                      //     child: homeContainer("migration.png", "Migrer un compteur", "Migration d'un compteur STS4 à STS6")
                      // ),
                      // SizedBox(height: SWS.height(15),),
                      // InkWell(
                      //     onTap: (){
                      //       Get.toNamed(Routes.MIGRATION);
                      //     },
                      //     child: homeContainer("local.png", "Localiser un compteur", "Tracer d'itineraire")
                      // ),
                      SizedBox(height: SWS.height(15),),
                      InkWell(
                          onTap: (){
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: homeContainer("ajouter.png", "Nouveau", "Enregistrer un compteur inexistant")
                      ),
                      SizedBox(height: SWS.height(15),),
                      InkWell(
                          onTap: (){
                            controller.syncData();
                          },
                          child: homeContainer("synchroniser.png", "Synchronisation", "Effectuer une synchronisation des données sauvegardées en local")
                      )
                    ],
                  )
                  // Container(
                  //   height: 100,
                  //   width: Get.width,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //           color: primaryColor.withOpacity(.2)
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: primaryColor.withOpacity(.2)
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     //crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text("Mes objectifs", style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w900,
                  //               color: primaryColor
                  //           ),),
                  //           SizedBox(height: 10,),
                  //           Text("${controller.objectifService.total.value}", style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w900,
                  //               color: primaryColor
                  //           ))
                  //         ],
                  //       ),
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text("Réalisés", style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w900,
                  //               color: primaryColor
                  //           ),),
                  //           SizedBox(height: 10,),
                  //           Text("${controller.objectifService.realises.value}", style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w900,
                  //               color: primaryColor
                  //           ))
                  //         ],
                  //       ),
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text("Restants", style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w900,
                  //               color: primaryColor
                  //           ),),
                  //           SizedBox(height: 10,),
                  //           Text("${controller.objectifService.total.value - controller.objectifService.realises.value}", style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w900,
                  //               color: primaryColor
                  //           ))
                  //         ],
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 30,),
                  // Text("Options", style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w900,
                  // )),
                  // SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          controller.searchLoad.value
              ?
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.white30
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: SWS.height(110),
                  width: Get.width * .6,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: Colors.white,
                        size: SWS.fontSize(35),
                      ),
                      SizedBox(height: SWS.height(5),),
                      Text("Vérification en cours...", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ) : SizedBox(height: 0, width: 0,)
        ],
      ))
    );
  }
}


Container homeContainer(String imgName, String lib, String descr, {Color color = Colors.transparent}){
  return Container(
    height: SWS.height(75),
    decoration: BoxDecoration(
        border: Border.all(
            color: primaryColor.withOpacity(.2)
        ),
        borderRadius: BorderRadius.circular(10),
      color: color
    ),
    child: Row(
      children: [
        SizedBox(width: SWS.width(15),),
        Image.asset("assets/${imgName}", height: SWS.height(50),),
        SizedBox(width: SWS.width(15),),
        Expanded(
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lib, style: TextStyle(
                    fontSize: SWS.fontSize(22),
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),),
                  SizedBox(height: SWS.height(5),),
                  Text(descr, style: TextStyle(
                    fontSize: SWS.fontSize(15),
                    color: Colors.grey.shade500
                  ),)
                ],
              )
            ],
          ),
        )

      ],
    ),
  );
}


Container homeContainer2(String imgName, Function() function1, Function() function2, {Color color = Colors.transparent}){
  return Container(
    height: SWS.height(75),
    decoration: BoxDecoration(
        border: Border.all(
            color: primaryColor.withOpacity(.2)
        ),
        borderRadius: BorderRadius.circular(10),
      color: color
    ),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 15,),
        Image.asset("assets/${imgName}", height: SWS.height(50),),
        SizedBox(width: 15,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text("Rechercher un compteur", style: TextStyle(
                    fontSize: SWS.fontSize(22),
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                ),),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: function1,
                  child: Container(
                    height: SWS.height(30),
                    width: SWS.width(100),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: SWS.fontSize(18),),
                        SizedBox(width: 3,),
                        Text('Saisir', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: SWS.fontSize(15)
                        ),)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                InkWell(
                  onTap: function2,
                  child: Container(
                    height: SWS.height(30),
                    width: SWS.width(100),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_scanner, color: Colors.white, size: SWS.fontSize(18),),
                        SizedBox(width: 3,),
                        Text('Scanner', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: SWS.fontSize(15)
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    ),
  );
}
