import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

class LoginController extends GetxController with MixinController {
  LoginController(this.schoolUseCase, this.sharePreferencesConstants);

  GlobalKey<FormState> textFormKey = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<LoadedType> rxLoginLoadedType = LoadedType.finish.obs;

  RxBool isShow = false.obs;

  SchoolUseCase schoolUseCase;
  SharePreferencesConstants sharePreferencesConstants;

  void onPressedShowPassword() {
    isShow.value = !isShow.value;
    debugPrint('hehehhe');
  }

  Future<void> onPressedLogin() async {
    rxLoginLoadedType.value = LoadedType.start;

    if (accountController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      return;
    }

    try {
      final result = await schoolUseCase.getSchoolSchedule(
          username: accountController.text.trim().toUpperCase(),
          password: passwordController.text.trim());
      debugPrint('===============$result');
      if (!isNullEmpty(result)) {
        schoolUseCase.insertSchoolScheduleLocal(result?.studentSchedule ?? []);
        schoolUseCase.setStudentInfoLocal(result?.studentInfo ?? StudentInfo());
        if (!isNullEmpty(result?.studentSchedule) ||
            !isNullEmpty(result?.studentInfo)) {
          sharePreferencesConstants.setIsLogIn(isLogIn: true);
        }
        rxLoginLoadedType.value = LoadedType.finish;
        debugPrint('===============');
        Get.offAndToNamed(AppRoutes.main);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
    rxLoadedType.value = LoadedType.start;
  }
}
