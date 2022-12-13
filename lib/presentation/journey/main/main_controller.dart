import 'package:get/get.dart';

import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

class MainController extends GetxController with MixinController {
  RxInt rxCurrentNavIndex = 0.obs;

  void onChangedNav(int index) {
    rxCurrentNavIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.dark);
  }
}