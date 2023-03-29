import 'dart:developer';

import 'package:http/http.dart' as http;

import '../data/constant.dart';

class AuthProvider {
  String url =
      "${keycloakUrl}/realms/${realm}/protocol/openid-connect/token";

  login(String username, String password) async {
    Map<String, String> headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'cache-control': 'no-cache'
    };

    Map<String, String> data = {
      'client_id': client_id,
      'username': username.trim(),
      'password': password.trim(),
      'grant_type': 'password'
    };

    try {
      final http.Response response =
      await http.post(Uri.parse(url), headers: headers, body: data);
      if(response.statusCode == 200){
        return response.body;
      } else if(response.statusCode == 401){
        return Future.error("Identifiant/Mot de passe incorrect");
      } else {
        return Future.error("Un problème est survenu");
      }

    } catch (e) {
      log("error provider ================> ${e}");
      return Future.error("Une erreur est survenue");
    }
  }

  logout() {}
}
