import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/network/api_exceptions.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/score_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/snack_bar/flash.dart';

class PersonalController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  final formKey = GlobalKey<FormState>();
  final ScoreController scoreController = Get.find<ScoreController>();
  Rx<LoadedType> rxPersonalLoadedType = LoadedType.finish.obs;
  ScoreUseCase scoreUseCase;
  SchoolUseCase schoolUseCase;
  PersonalUsecase personalUsecase;
  SharePreferencesConstants sharePreferencesConstants;
  RxBool keepOldSchedule = false.obs;
  final passwordController = TextEditingController();

  RxBool isShowPassword = false.obs;
  PersonalController(
      {required this.schoolUseCase,
      required this.personalUsecase,
      required this.scoreUseCase,
      required this.sharePreferencesConstants});

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> logOut() async {
    try {
      await schoolUseCase.deleteStudentInfo();
      await schoolUseCase.deleteAllSchoolSchedulesLocal();
      await personalUsecase.deleteAllPersonalSchedulesLocal();
      await sharePreferencesConstants.setIsLogIn(isLogIn: false);
      scoreController.clearScreenData();
      await scoreUseCase.clearDataScore();
      mainController.rxCurrentNavIndex.value = 0;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {}
  }

  Future<void> clearDataScore() {
    return scoreUseCase.clearDataScore();
  }

  // ignore: use_build_context_synchronously
  void updateSchedule() async {
    String? username = mainController.studentInfo.value.studentCode ?? '';
    if (!formKey.currentState!.validate()) {
      return;
    }
    String password = passwordController.text;

    if (!await NetworkState.isConnected) {
      showTopSnackBar(context,
          message: 'Không có kết nối Internet', type: SnackBarType.error);
      return;
    }

    if (username.isEmpty || password.isEmpty) {
      return;
    }

    try {
      rxLoadedType.value = LoadedType.start;
      final result = await schoolUseCase.getSchoolSchedule(
          username: username.trim().toUpperCase(), password: password.trim());
      if (!isNullEmpty(result)) {
        if (keepOldSchedule.value) {
          await schoolUseCase.deleteAllSchoolSchedulesLocal();
          await schoolUseCase
              .insertSchoolScheduleLocal(result?.studentSchedule ?? []);
        } else {
          List<StudentSchedule> oldSchedule =
              await schoolUseCase.getSchoolScheduleLocal();
          // xóa môn đang có ở lịch cũ
          result?.studentSchedule?.removeWhere((element) {
            return oldSchedule
                .any((old) => old.subjectCode == element.subjectCode);
          });
          // thêm môn mới vào lịch cũ
          await schoolUseCase
              .insertSchoolScheduleLocal(result?.studentSchedule ?? []);
        }

        showTopSnackBar(context,
            message: 'Cập nhật lịch học thành công', type: SnackBarType.done);
      } else {
        showTopSnackBar(context,
            message: 'Cập nhật lịch học thất bại', type: SnackBarType.error);
      }
    } on WrongPasswordError {
      showTopSnackBar(
        context,
        message: 'Cập nhật lịch học thất bại',
        type: SnackBarType.error,
      );
    } catch (e) {
      debugPrint(e.toString());
      showTopSnackBar(
        context,
        message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
        type: SnackBarType.error,
      );
    }
    passwordController.clear();
    Get.back();
    rxLoadedType.value = LoadedType.finish;
  }
}
