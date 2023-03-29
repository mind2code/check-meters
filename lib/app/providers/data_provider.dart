

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../data/constant.dart';
import '../services/token_service.dart';

class DataProvider {
  TokenService tokenService = Get.find<TokenService>();
  
  postNewCpt(Map _data) async {
    Map<String, dynamic> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${tokenService.getTokenBrut()}"
    };
    
    final response = await Dio().post(
        "$base_url/api/v1/collecte/meters",
        data: _data,
      options: Options(
        headers: headers
      )
    );

    log('response ===================> ${response.statusCode}');
    
    if(response.statusCode == 201){
      return response;
    } else {
      return Future.error("Une erreur est survenue");
    }
  }

  String urlSearch = "/selfcare-api/v1/bd_centralisee/search?numero_compteur=";

  searchCompteur(String identifiant) async {

    Map<String, dynamic> headers = {
      "Authorization": "Bearer ${tokenService.getTokenBrut()}"
    };

    final response = await Dio().get(base_url+urlSearch+"$identifiant", options: Options(
      headers: headers
    ));

    print("response ===========> ${response.statusCode}");

    if(response.statusCode == 200){
      return response.data;
    } else {
      return Future.error('une erreur est survenue');
    }
  }


  getToken(String compteur) async {
    Map _body = {
      "version": 0,
      "seed": "12345678",
      "user": "admin",
      "getinfo": 0,
      "device": compteur
    };

    //37226829697

    final response = await Dio().get(
        "http://10.10.152.62:8080/portal/selfcare/interface?action=get_token",
      data: _body
    );

    print("response ================> ${response.data}");

    if(response.statusCode == 200){
      return jsonDecode(response.data);
    } else {
      return Future.error("Une erreur est survenue");
    }



  }


}