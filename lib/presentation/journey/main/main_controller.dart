import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

class MainController extends GetxController with MixinController {
  RxInt rxCurrentNavIndex = 0.obs;
  Rx<StudentInfo> studentInfo = StudentInfo().obs;
  SchoolUseCase schoolUseCase;

  MainController(this.schoolUseCase);

  void onChangedNav(int index) {
    rxCurrentNavIndex.value = index;
  }

  void getStudentInfoLocal() {
    studentInfo.value = schoolUseCase.getStudentInfoLocal() ?? StudentInfo();
  }

  @override
  void onInit() {
    super.onInit();
    getStudentInfoLocal();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.dark);
  }

  @override
  void onReady() {
    rxLoadedType.value = LoadedType.start;

    rxLoadedType.value = LoadedType.finish;
  }
}
