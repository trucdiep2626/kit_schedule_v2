import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

class MainController extends GetxController with MixinController {
  RxInt rxCurrentNavIndex = 0.obs;
  Rx<SchoolScheduleModel> schoolScheduleModel = SchoolScheduleModel().obs;

  void onChangedNav(int index) {
    rxCurrentNavIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('------${Get.arguments}');
    schoolScheduleModel.value = Get.arguments;
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.dark);
  }
}