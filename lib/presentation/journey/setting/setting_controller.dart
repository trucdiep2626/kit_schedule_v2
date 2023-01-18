import 'package:get/get.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/mixin_controller.dart';

import '../../../common/constants/shared_preferences_constants.dart';

class SettingController extends GetxController with MixinController {
  RxBool isNotification = SharePreferencesConstants().getIsNotification().obs;
  RxInt timeNotification =
      SharePreferencesConstants().getTimeNotification().obs;
  SharePreferencesConstants sharePreferencesConstants;

  SettingController({required this.sharePreferencesConstants});

  void onChangedNotification(bool value) {
    isNotification.value = value;
    sharePreferencesConstants.setNotification(isNotification: value);
  }

  void onChangedTimeNotification(int newValue) {
    timeNotification.value = newValue;
    sharePreferencesConstants.setTimeNotification(timeNotification: newValue);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
