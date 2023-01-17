import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/text_field_add_score.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/snack_bar/app_snack_bar.dart';

class ScoreController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxScoreLoadedType = LoadedType.finish.obs;
  SchoolUseCase schoolUseCase;
  Rx<StudentScores?> studentScores = (null as StudentScores?).obs;

  ScoreController(this.schoolUseCase);
  Future<void> onRefresh() async {
    if (!await NetworkState.isConnected) {
      showTopSnackBar(context,
          message: 'Không có kết nối Internet', type: SnackBarType.error);
      return;
    }

    rxScoreLoadedType.value = LoadedType.start;
    await getScores();
    rxScoreLoadedType.value = LoadedType.finish;
  }

  Future<void> getScores() async {
    rxScoreLoadedType.value = LoadedType.start;

    final studentCode =
        Get.find<MainController>().studentInfo.value.studentCode;

    if (studentCode == null || studentCode.isEmpty) {
      rxScoreLoadedType.value = LoadedType.finish;
      return;
    }

    try {
      final result = await schoolUseCase.getScore(studentCode: studentCode);

      if (!isNullEmpty(result)) {
        studentScores.value = result!;
      }
    } catch (e) {
      showTopSnackBar(context,
          message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
          type: SnackBarType.error);
    }
    rxScoreLoadedType.value = LoadedType.finish;
  }

  Future<void> displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // shape: ,
            title: Container(
              padding: EdgeInsets.all(16.sp),
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue900,
              child: Text(
                'Thêm môn học',
                style: ThemeText.bodySemibold
                    .copyWith(color: AppColors.bianca, fontSize: 18.sp),
                textAlign: TextAlign.center,
              ),
            ),
            content: SizedBox(
              height: 270.h,
              width: 300.w,
              child: Column(
                children: const [
                  TextFieldAddScore(),
                  TextFieldAddScore(),
                  TextFieldAddScore(),
                  TextFieldAddScore(),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {},
              ),
            ],
          );
        });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    onRefresh();
  }
}
