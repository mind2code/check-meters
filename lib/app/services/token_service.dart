import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/user.dart';

class TokenService extends GetxService {
  final box = GetStorage();
  Rx<User> user = User().obs;

  String tokenKey = "authentification_token_key";

  init() async {
    getToken();
    return this;
  }

  setToken(String token) {
    box.write(tokenKey, token);
  }

  getTokenBrut() {
    return box.read(tokenKey);
  }

  getToken() {
    final response = getTokenBrut();
    if (response != null && !JwtDecoder.isExpired(response)) {
      final decoded = JwtDecoder.decode(response);
      user.value.name = decoded['name'];
      user.value.givenName = decoded['given_name'];
      user.value.email = decoded['email'];
      user.value.username = decoded['preferred_username'];
      user.value.familyName = decoded['family_name'];
      return decoded;
    }
    return null;
  }

  removeToken() {
    box.remove(tokenKey);
  }
}
