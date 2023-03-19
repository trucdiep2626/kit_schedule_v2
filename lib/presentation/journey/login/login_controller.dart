import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/common/config/network/api_exceptions.dart';
import 'package:schedule/common/config/network/network_state.dart';
import 'package:schedule/common/utils/analytics_utils.dart';
import 'package:schedule/domain/models/student_info_model.dart';
import 'package:schedule/domain/usecases/school_usecase.dart';
import 'package:schedule/presentation/controllers/analytics_controller.dart';
import 'package:schedule/presentation/controllers/mixin/export.dart';
import 'package:schedule/presentation/journey/login/login_success_dialog.dart';
import 'package:schedule/presentation/widgets/snack_bar/app_snack_bar.dart';

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
  }

  Future<void> onPressedLogin() async {
    FocusScope.of(context).unfocus();

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
        getIt<AnalyticsController>().logEvent(AnalyticsEventType.login);
        sharePreferencesConstants.setShowDialog(showDialog: true);
        Get.offAndToNamed(AppRoutes.main);
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
    rxLoadedType.value = LoadedType.finish;
  }
}
