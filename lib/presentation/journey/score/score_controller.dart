import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/data/remote/score_respository.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/score_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_color.dart';
import 'package:kit_schedule_v2/presentation/widgets/snack_bar/app_snack_bar.dart';

import 'components/button_add_scores.dart';
import 'components/navigator_add_subject.dart';

class ScoreController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  final SchoolUseCase schoolUseCase;
  final ScoreUseCase scoreUseCase;
  Rx<HiveScoresCell> rxHiveScoresCell = (null as HiveScoresCell).obs;
  RxList<bool> rxExpandedList = <bool>[].obs;
  Rx<StudentScores?> rxStudentScores = (null as StudentScores?).obs;
  ScoreController(this.schoolUseCase, this.scoreUseCase);
  TextEditingController firstComponentScore = TextEditingController();
  TextEditingController secondComponentScore = TextEditingController();
  TextEditingController examScore = TextEditingController();
  Future<void> onRefresh() async {
    if (!await NetworkState.isConnected) {
      showTopSnackBar(context,
          message: 'Không có kết nối Internet', type: SnackBarType.error);
      return;
    }

    rxLoadedType.value = LoadedType.start;
    await getScores();
    rxLoadedType.value = LoadedType.finish;
  }

  Future<void> getScores() async {
    rxLoadedType.value = LoadedType.start;

    final studentCode =
        Get.find<MainController>().studentInfo.value.studentCode;

    if (studentCode == null || studentCode.isEmpty) {
      rxLoadedType.value = LoadedType.finish;
      return;
    }

    try {
      final result =
          await scoreUseCase.getScoresStudents(studentCode: studentCode);
      if (!isNullEmpty(result)) {
        rxStudentScores.value = result!;
        rxExpandedList.value = List.generate(
            scoreUseCase.getLengthHiveScoresCell(), (index) => false);
      }
      for (int index = 0; index < result!.scores!.length; index++) {
        if (!isNullEmpty(result)) {
          if (result.scores![index].subject!.id!.contains("ATQGTC1") ||
              result.scores![index].subject!.id!.contains("ATQGTC2") ||
              result.scores![index].subject!.id!.contains("ATQGTC3") ||
              result.scores![index].subject!.id!.contains("ATQGTC4") ||
              result.scores![index].subject!.id!.contains("ATQGTC5")) {
            index++;
          } else {
            if (scoreUseCase.isDuplicate(result, index)) {
              scoreUseCase.insertSubjectFromAPI(result, index);
            }
          }
        }
      }
    } catch (e) {
      showTopSnackBar(
        Get.context!,
        message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
        type: SnackBarType.error,
      );
    }
    rxLoadedType.value = LoadedType.finish;
  }

  Future<void> addScoreEng(
      String? name, String? id, String? numberOfCredits) async {
    int n = 0;
    for (int i = 0; i < getIt<HiveConfig>().hiveScoresCell.length; i++) {
      if (getIt<HiveConfig>().hiveScoresCell.values.elementAt(i).name == name) {
        n++;
      }
    }
    if (n == 0) {
      try {
        scoreUseCase.insertScoreEng(
          HiveScoresCell(
            alphabetScore: scoreUseCase.calAlphabetScore(
                examScore: examScore.text,
                firstComponentScore: firstComponentScore.text,
                secondComponentScore: secondComponentScore.text),
            avgScore: scoreUseCase
                .calAvgScore(
                    examScore: examScore.text,
                    firstComponentScore: firstComponentScore.text,
                    secondComponentScore: secondComponentScore.text)!
                .toStringAsFixed(2),
            examScore: examScore.text.trim(),
            firstComponentScore: firstComponentScore.text.trim(),
            id: id,
            name: name,
            numberOfCredits: int.parse(numberOfCredits!),
            secondComponentScore: secondComponentScore.text.trim(),
          ),
        );
        showTopSnackBar(context,
            message: 'Thêm môn học thành công', type: SnackBarType.done);
        Get.back();
      } catch (e) {
        showTopSnackBar(context,
            message:
                'Các trường phải được điền chính xác và không được bỏ trống',
            type: SnackBarType.error);
      }
    }
    if (n != 0) {
      try {
        showTopSnackBar(context,
            message: 'Môn học đã tồn tại', type: SnackBarType.error);
      } catch (e) {
        showTopSnackBar(context,
            message: 'Các trường phải điền chính xác và không được bỏ trống',
            type: SnackBarType.error);
      }
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    onRefresh();
  }

  void setExpandedCell(int index, bool expanded) {
    rxExpandedList.fillRange(0, rxExpandedList.length, false);
    rxExpandedList[index] = !expanded;
  }
}
