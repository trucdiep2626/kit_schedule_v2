import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/network/api_exceptions.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/login/login_success_dialog.dart';
import 'package:kit_schedule_v2/presentation/widgets/snack_bar/app_snack_bar.dart';

class LoginController extends GetxController with MixinController {
  LoginController(this.schoolUseCase, this.sharePreferencesConstants);

  GlobalKey<FormState> textFormKey = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode accountFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  RxBool isShowingPassword = false.obs;
  RxBool isPasswordFocused = false.obs;

  SchoolUseCase schoolUseCase;
  SharePreferencesConstants sharePreferencesConstants;

  void onPressedShowPassword() {
    isShowingPassword.value = !isShowingPassword.value;
    debugPrint('hehehhe');
  }

  Future<void> onPressedLogin() async {
    if (!textFormKey.currentState!.validate()) {
      return;
    }

    if (!await NetworkState.isConnected) {
      showTopSnackBar(context,
          message: 'Không có kết nối Internet', type: SnackBarType.error);
      return;
    }

    rxLoadedType.value = LoadedType.start;

    if (accountController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      return;
    }

    try {
      final result = await schoolUseCase.getSchoolSchedule(
          username: accountController.text.trim().toUpperCase(),
          password: passwordController.text.trim());
      if (!isNullEmpty(result)) {
        schoolUseCase.insertSchoolScheduleLocal(result?.studentSchedule ?? []);
        schoolUseCase.setStudentInfoLocal(result?.studentInfo ?? StudentInfo());

        if (!isNullEmpty(result?.studentSchedule) ||
            !isNullEmpty(result?.studentInfo)) {
          sharePreferencesConstants.setIsLogIn(isLogIn: true);
        }
        Get.offAndToNamed(AppRoutes.main);
        loginSuccessDialog(Get.context!);
      } else {
        showTopSnackBar(
          context,
          message: 'Tài khoản đăng nhập không đúng',
          type: SnackBarType.error,
        );
      }
    } on WrongPasswordError {
      showTopSnackBar(context,
          message: 'Đăng nhập thất bại', type: SnackBarType.error);
    } catch (e) {
      debugPrint(e.toString());
      showTopSnackBar(context,
          message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
          type: SnackBarType.error);
    }
    accountFocusNode.requestFocus();
    rxLoadedType.value = LoadedType.finish;
  }
}
