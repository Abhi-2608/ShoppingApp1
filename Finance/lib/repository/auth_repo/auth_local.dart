import 'package:get_storage/get_storage.dart';

class AuthLocal {
  static dynamic getUser() {
    return GetStorage().read('auth_user');
  }

  static bool setUser(dynamic user) {
    GetStorage().write('auth_user', user);
    return true;
  }

  static String getToken() {
    return GetStorage().read('access_token') ?? '';
  }

  static bool setToken(dynamic token) {
    GetStorage().write('access_token', token);
    return true;
  }
}
