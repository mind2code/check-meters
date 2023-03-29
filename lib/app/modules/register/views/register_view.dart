import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../data/constant.dart';
import '../../../widgets/customFormField.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    log("datetime =========> ${DateTime.now().toIso8601String()}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Nouveau'),
        centerTitle: true,
      ),
      body: Obx(() => Container(
          padding: EdgeInsets.symmetric(
            // horizontal: 10
          ),
          child: SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: .5,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            body: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: controller.initialPosition.value,
              markers: Set<Marker>.from(controller.markers.value),
              onMapCreated: (GoogleMapController _controller) async {
                controller.googleMapController = _controller;

                if(!controller.completer.isCompleted){
                  controller.completer.complete(_controller);
                }
                String style = await rootBundle.loadString('assets/map_style.json');
                await controller.googleMapController!.setMapStyle(style);
                // try {
                //   if(!controller.completer.isCompleted){
                //     controller.completer.complete(_controller);
                //   }
                // } catch (e){
                //
                // }



              },
              onTap: (latLng){
                controller.setUserMarker(latLng);
              },
            ),
            controller: controller.panelController,
            minHeight: controller.minHeigth.value,
            maxHeight: controller.openHeigth.value,
            onPanelSlide: (d){
              controller.openedPanel();
              controller.bottomH.value = d * (
                  controller.openHeigth.value - controller.minHeigth.value) + controller.minHeigth.value;
            },
            onPanelClosed: (){
            },
            panelBuilder: (sc){
              return MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    controller: sc,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            //SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await controller.panelController.open();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 30,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: 5,),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Informations supplémentaires", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                            SizedBox(height: 25,),
                            Form(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  // CustomDropdownField(
                                  //   value: controller.dr,
                                  //   lab: "Dr",
                                  //   items: [
                                  //     "022",
                                  //     "023",
                                  //   ],
                                  //   validator: (s){
                                  //     if(!s.isNotNull2){
                                  //       return 'Veuillez choisir la Dr';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  // SizedBox(height: 15,),
                                  // CustomDropdownField(
                                  //   value: controller.secteur,
                                  //   lab: "Secteur",
                                  //   items: [
                                  //     "034",
                                  //     "035",
                                  //   ],
                                  //   validator: (s){
                                  //     if(!s.isNotNull2){
                                  //       return 'Veuillez choisir le secteur';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  // SizedBox(height: 15,),
                                  // CustomDropdownField(
                                  //   value: controller.tournee,
                                  //   lab: "Tournée",
                                  //   items: [
                                  //     "045",
                                  //     "046",
                                  //   ],
                                  //   validator: (s){
                                  //     if(!s.isNotNull2){
                                  //       return 'Veuillez choisir la tournée';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  //SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.dr2,
                                    lab: "Direction regionale",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [
                                    ],
                                    validator: (s){
                                      if(!s.isNotNull){
                                        return "Veuillez entrer la direction regionale";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.secteur2,
                                    lab: "Secteur",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                    validator: (s){
                                      if(!s.isNotNull){
                                        return "Veuillez entrer le sectteur";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.tournee2,
                                    lab: "Tournéé",
                                    type: TextInputType.number,
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9]+|\s"),
                                      )
                                    ],
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer la tournée";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.compteurNum,
                                    lab: "N° compteur",
                                    type: TextInputType.number,
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9]+|\s"),
                                      )
                                    ],
                                    validator: (s){
                                      if(!s.isNotNull){
                                        return "Veuillez entrer le numéro du compteur";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.referenceClient,
                                    lab: "Réference client",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer la réference du client";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.referenceContrat,
                                    lab: "Réference contrat",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer la réference du contrat";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.nomAbonne,
                                    lab: "Nom de l'abonné",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer le nom de l'abonné";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.prenomAbonne,
                                    lab: "Prénoms de l'abonné",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer le prénom de l'abonné";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    type: TextInputType.phone,
                                    controller: controller.contactPrincipal,
                                    lab: "Contact principal",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer le contact principal";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  CustomFormField(
                                    type: TextInputType.phone,
                                    controller: controller.contactSecondaire,
                                    lab: "Contact secondaire",
                                    onChanged: (s){},
                                    readOnly: false,
                                    inputFormatters: [

                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  // CustomDropdownField(
                                  //   value: controller.reglageDis,
                                  //   lab: "Reglage disjoncteur",
                                  //   items: [
                                  //     "5A",
                                  //     "10A",
                                  //     "15A"
                                  //   ],
                                  //   validator: (s){
                                  //     if(!s.isNotNull2){
                                  //       return 'Veuillez choisir la tournée';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  // SizedBox(height: 15,),
                                  // CustomDropdownField(
                                  //   value: controller.typeCpt,
                                  //   lab: "Type de compteur",
                                  //   items: [
                                  //     "Prepaid",
                                  //     "Postpaid",
                                  //   ],
                                  //   validator: (s){
                                  //     if(!s.isNotNull2){
                                  //       return 'Veuillez choisir la tournée';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),
                                  // SizedBox(height: 15,),
                                  CustomFormField(
                                    controller: controller.sitGeo,
                                    lab: "Situation géographique",
                                    onChanged: (s){},
                                    readOnly: false,
                                    validator: (s){
                                      // if(!s.isNotNull){
                                      //   return "Veuillez entrer la situation géograpique";
                                      // }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            // Column(
                            //   children: formBuilder({}.obs),
                            // ),
                            // SizedBox(height: 30,),
                            Obx(() => InkWell(
                              onTap: controller.submitNew,
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: controller.isLoading.value ? primaryColor.withOpacity(.5) : primaryColor,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: controller.isLoading.value ?
                                SpinKitFadingCircle(
                                  color: Colors.white,
                                  size: 25,
                                ) : Text("Valider", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                              ),
                            )),
                            SizedBox(height: 30,),
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          )
      ))
    );
  }
}
