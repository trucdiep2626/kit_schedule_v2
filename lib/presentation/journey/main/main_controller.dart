import 'package:get/get.dart';

import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/analytics_controller.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_item.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';

class MainController extends GetxController with MixinController {
  RxInt rxCurrentNavIndex = 0.obs;
  Rx<StudentInfo> studentInfo = StudentInfo().obs;
  SchoolUseCase schoolUseCase;
  RxBool isLogin = false.obs;
  SharePreferencesConstants sharePreferencesConstants;
  MainController(this.schoolUseCase, this.sharePreferencesConstants);

  Future<void> onChangedNav(int index) async {
    rxCurrentNavIndex.value = index;
    getIt<AnalyticsController>()
        .logEvent(MainItem.values[index].getEventType());
    if (index == 0) {
      await Get.find<HomeController>().getScheduleLocal();
    }
    isLogin.value = sharePreferencesConstants.getIsLogIn();
    if (isLogin.value) {
      ScoreController scoreController = Get.find<ScoreController>();
      scoreController.getData(); //lấy data theo local hoặc lấy data theo api
    }
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
}
