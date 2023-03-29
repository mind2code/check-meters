import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helpers/database.dart';
import '../../../models/data.dart';
import '../../../models/data_local.dart';
import '../../../providers/data_provider.dart';
import '../../../services/token_service.dart';
import '../../../widgets/status_response.dart';

class RegisterController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  DataProvider dataProvider = Get.put(DataProvider());
  TokenService tokenService = Get.find();

  Location? location;
  LocationData? _locationData;

  TileOverlay? tileOverlay;

  Completer<GoogleMapController> completer = Completer();
  GoogleMapController? googleMapController;
  Rx<CameraPosition> initialPosition = CameraPosition(
    target: LatLng(5.3078344,-4.0184672),
    zoom: 10,
  ).obs;

  TextEditingController tournee2 = TextEditingController();
  TextEditingController secteur2 = TextEditingController();
  TextEditingController dr2 = TextEditingController();

  TextEditingController compteurNum = TextEditingController();
  TextEditingController referenceClient = TextEditingController();
  TextEditingController referenceContrat = TextEditingController();
  TextEditingController nomAbonne = TextEditingController();
  TextEditingController prenomAbonne = TextEditingController();
  TextEditingController contactPrincipal = TextEditingController();
  TextEditingController contactSecondaire = TextEditingController();
  TextEditingController sitGeo = TextEditingController();
  Rxn dr = Rxn<String>();
  Rxn secteur = Rxn<String>();
  Rxn tournee = Rxn<String>();
  Rxn reglageDis = Rxn<String>();
  Rxn typeCpt = Rxn<String>();

  final formKey = GlobalKey<FormState>();

  RxList<Marker> markers = <Marker>[].obs;


  @override
  void onInit() async {
    super.onInit();
    compteurNum = TextEditingController(text:
    (Get.arguments != null && Get.arguments['param'] != null)
        ? Get.arguments['param'] : ""
    );
    googleMapController =  await completer.future;

    await getLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Map? checkData(){
    if(formKey.currentState!.validate()){
      Compteur compteur = Compteur(
        compteur: compteurNum.text.trim(),
          dr: dr2.text.trim(),
          secteur: secteur2.text.trim(),
          tournee: tournee2.text.trim(),
          referenceClient: referenceClient.text.trim(),
          referenceContrat: referenceContrat.text.trim(),
          nomAbonne: nomAbonne.text.trim(),
          prenomsAbonne: prenomAbonne.text.trim(),
          contact: contactPrincipal.text.trim(),
          contact_secondaire: contactSecondaire.text.trim(),
          reglageDisjoncteur: reglageDis.value,
          situationGeographique: sitGeo.text.trim(),
          typeCompteur: typeCpt.value,
          // coordonnees: Coordonnees(
          //     longitude: markers.isNotEmpty ? markers[0].position.longitude.toString() : _locationData!.longitude.toString(),
          //     latitude: markers.isNotEmpty ? markers[0].position.latitude.toString() : _locationData!.latitude.toString()
          // ),
        agent: tokenService.user.value.username,
        createdAt: DateTime.now()
      );

      log("data ============> ${compteur.toJson()}");

      return compteur.toJson();
    }
    return null;

  }


  submitNew() async {
    if(checkData() != null){
      isLoading.value = true;
      try {
        final response = await dataProvider.postNewCpt(checkData()!);
        hasError.value = false;
      } catch(e){
        hasError.value = true;
        await DatabaseHelper.instance.insert(
            LocalData(
              data: jsonEncode(checkData()),
              sync: 0
            )
        );
      }

      isLoading.value = false;

      statusResponseSearch(
        hasError.value ? DialogType.warning : DialogType.success,
        "Succès",
        hasError.value ? "Donnée a été sauvegardée en local" : "Operation effectuée avec succès",
      );
    }
  }

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();


    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target:
        LatLng(_locationData!.latitude!, _locationData!.longitude!),
            zoom: 14.0
        )
    ));
  }

  setUserMarker(LatLng latLng){
    Marker _user_marker = Marker(
      markerId: MarkerId("user_location"),
      position: LatLng(latLng.latitude, latLng.longitude),
      infoWindow: InfoWindow(
        title: 'Votre position',
        snippet: "(${latLng.latitude}, ${latLng.longitude})"
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    if(!markers.isEmpty){
      Marker marker = markers.firstWhere((element) =>
      element.markerId.value == "user_location");
      markers.remove(marker);
    }
    markers.add(_user_marker);
  }



  /// panel
  RxDouble minHeigth = 50.0.obs;
  RxDouble bottomH = 55.0.obs;
  RxDouble openHeigth = (Get.height * .75).obs;
  PanelController panelController = PanelController();
  RxBool isOpened = false.obs;

  openedPanel(){
    if(panelController.isAttached && panelController.isPanelOpen){
      isOpened.value = true;
    } else {
      isOpened.value = false;
    }

  }

}
