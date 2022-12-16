import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesConstants {
  static late SharedPreferences prefs;

  static String phone = 'phone';
  static String isLogin = 'is_log_in';

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setIsLogIn({required bool isLogIn}) {
    return prefs.setBool(isLogin, isLogIn);
  }

  bool getIsLogIn() {
    return prefs.getBool(isLogin) ?? false;
  }
}
