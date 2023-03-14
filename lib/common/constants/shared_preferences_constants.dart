import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesConstants {
  static late SharedPreferences prefs;

  static String isLogin = 'is_log_in';
  static const String kIsNotification = "is_notification";
  static const String kTimeNotification = "time_notification";
  static const String kHasRunBefore = 'hasRunBefore';
  static const String kShowDialog = 'showDialog';
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setTimeNotification({required int timeNotification}) {
    return prefs.setInt(kTimeNotification, timeNotification);
  }

  int getTimeNotification() {
    return prefs.getInt(kTimeNotification) ?? 0;
  }

  Future<bool> setShowDialog({required bool showDialog}) {
    return prefs.setBool(kShowDialog, showDialog);
  }

  bool getShowDialog() {
    return prefs.getBool(kShowDialog) ?? false;
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

  Future<void> clearDataOnReinstall() async {
    if (!(prefs.getBool(kHasRunBefore) ?? false)) {
      final hiveConfig = getIt<HiveConfig>();
      await hiveConfig.studentBox.clear();
      await hiveConfig.hiveScoresCell.clear();
      await hiveConfig.personalBox.clear();
      await hiveConfig.scheduleBox.clear();
      prefs.setBool(kHasRunBefore, true);
    }
  }
}
