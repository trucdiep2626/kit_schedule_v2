import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesConstants {
  static late SharedPreferences prefs;

  static String isLogin = 'is_log_in';
  static const String kIsNotification = "is_notification";
  static const String kTimeNotification = "time_notification";

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setTimeNotification({required int timeNotification}) {
    return prefs.setInt(kTimeNotification, timeNotification);
  }

  int getTimeNotification() {
    return prefs.getInt(kTimeNotification) ?? 0;
  }

  Future<bool> setNotification({required bool isNotification}) {
    return prefs.setBool(kIsNotification, isNotification);
  }

  bool getIsNotification() {
    return prefs.getBool(kIsNotification) ?? false;
  }

  Future<bool> setIsLogIn({required bool isLogIn}) {
    return prefs.setBool(isLogin, isLogIn);
  }

  bool getIsLogIn() {
    return prefs.getBool(isLogin) ?? false;
  }
}
