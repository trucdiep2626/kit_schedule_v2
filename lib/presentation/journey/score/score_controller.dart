import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/data/remote/score_respository.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
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

  RxList<bool> rxExpandedList = <bool>[].obs;
  Rx<StudentScores?> rxStudentScores = (null as StudentScores?).obs;

  ScoreController(this.schoolUseCase);

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
      final result = await getIt<ScoreRepository>()
          .getScoresStudents(studentCode: studentCode);
      if (!isNullEmpty(result)) {
        rxStudentScores.value = result!;
        rxExpandedList.value =
            List.generate(result.scores?.length ?? 0, (index) => false);
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
            if (getIt<HiveConfig>()
                .hiveScoresCell
                .values
                .where((element) =>
                    element.id == result.scores![index].subject!.id)
                .isEmpty) {
              getIt<HiveConfig>().hiveScoresCell.add(HiveScoresCell(
                    alphabetScore: result.scores![index].alphabetScore,
                    avgScore: result.scores![index].avgScore,
                    examScore: result.scores![index].examScore,
                    firstComponentScore:
                        result.scores![index].firstComponentScore,
                    secondComponentScore:
                        result.scores![index].secondComponentScore,
                    name: result.scores![index].subject!.name,
                    id: result.scores![index].subject!.id,
                    numberOfCredits:
                        result.scores![index].subject!.numberOfCredits,
                  ));
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

  Future<void> displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
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
              height: 190.sp,
              child: Column(
                children: [
                  Expanded(
                    child: ButtonAddScore(
                      subjectName: "Tiếng Anh 1",
                      onPressed: () {
                        Get.to(() => const NavigatorAddSubject(
                              id: "ATCBNN1",
                              name: "Tiếng Anh 1",
                              numberOfCredits: "3",
                            ));
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.blue800,
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ButtonAddScore(
                      subjectName: "Tiếng Anh 2",
                      onPressed: () {
                        Get.to(() => const NavigatorAddSubject(
                              id: "LTCBNN2",
                              name: "Tiếng Anh 2",
                              numberOfCredits: "3",
                            ));
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.blue800,
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ButtonAddScore(
                      subjectName: "Tiếng Anh 3",
                      onPressed: () {
                        Get.to(() => const NavigatorAddSubject(
                              id: "ATCBNN6",
                              name: "Tiếng Anh 3",
                              numberOfCredits: "4",
                            ));
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.blue800,
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        });
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
