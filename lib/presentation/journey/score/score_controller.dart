import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/data/remote/score_repository.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/navigator_add_subject.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/srores_cell.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/button_add_scores.dart';
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
      final result = await getIt<ScoreRepository>()
          .getScoresStudents(studentCode: studentCode);
      studentScores.value = result;
      // final result =
      //     await getIt<ScoreRepository>().getScore(studentCode: studentCode);
      // log(result!.avgScore.toString());
      // for (int index = 0; index < result!.scores!.length; index++) {
      // if (!isNullEmpty(result)) {
      //   getIt<HiveConfig>().hiveScoresCell.add(HiveScoresCell(
      //         alphabetScore: result.scores![index].alphabetScore,
      //         avgScore: result.scores![index].avgScore,
      //         examScore: result.scores![index].examScore,
      //         firstComponentScore: result.scores![index].firstComponentScore,
      //         secondComponentScore:
      //             result.scores![index].secondComponentScore,
      //         name: result.scores![index].subject!.name,
      //         id: result.scores![index].subject!.id,
      //         numberOfCredits: result.scores![index].subject!.numberOfCredits,
      //       ));
      // }
      // }
      // for (int i = 0; i < getIt<HiveConfig>().hiveScoresCell.length; i++) {
      //   int n = 0;
      // getIt<HiveConfig>().hiveScoresCell.clear();
      int n = 0;
      for (int index = 0; index < result!.scores!.length; index++) {
        // if (!getIt<HiveConfig>()
        //     .hiveScoresCell
        //     .getAt(i)!
        //     .name!
        //     .toString()
        //     .contains(result.scores![index].subject!.name.toString())) {
        if (!isNullEmpty(result)) {
          if (result.scores![index].subject!.id!.contains("ATQGTC1") ||
              result.scores![index].subject!.id!.contains("ATQGTC2") ||
              result.scores![index].subject!.id!.contains("ATQGTC3") ||
              result.scores![index].subject!.id!.contains("ATQGTC4") ||
              result.scores![index].subject!.id!.contains("ATQGTC5")) {
            index++;
          } else {
            if (getIt<ScoreRepository>()
                    .checkDuplicate(result, index) == // mắc logic chỗ này!!!
                false) {
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
          // }
          // }
        }
        // if (n != 0) {
        //   if (!isNullEmpty(result)) {
        //     getIt<HiveConfig>().hiveScoresCell.add(HiveScoresCell(
        //           alphabetScore: result.scores![i].alphabetScore,
        //           avgScore: result.scores![i].avgScore,
        //           examScore: result.scores![i].examScore,
        //           firstComponentScore: result.scores![i].firstComponentScore,
        //           secondComponentScore: result.scores![i].secondComponentScore,
        //           name: result.scores![i].subject!.name,
        //           id: result.scores![i].subject!.id,
        //           numberOfCredits: result.scores![i].subject!.numberOfCredits,
        //         ));
        //   }
        // }
      }
    } catch (e) {
      log(getIt<ScoreRepository>()
          .getScore(studentCode: studentCode)
          .toString());
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
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // shape: ,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(6.0))),
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
              height: 186.h,
              width: 300.w,
              child: Column(
                children: [
                  ButtonAddScore(
                    subjectName: "Tiếng Anh 1",
                    onPressed: () {
                      Get.to(() => const NavigatorAddSubject(
                            id: "ATCBNN1",
                            name: "Tiếng Anh 1",
                            numberOfCredits: "3",
                          ));
                    },
                  ),
                  ButtonAddScore(
                    subjectName: "Tiếng Anh 2",
                    onPressed: () {
                      Get.to(() => const NavigatorAddSubject(
                            id: "LTCBNN2",
                            name: "Tiếng Anh 2",
                            numberOfCredits: "3",
                          ));
                    },
                  ),
                  ButtonAddScore(
                    subjectName: "Tiếng Anh 3",
                    onPressed: () {
                      Get.to(() => const NavigatorAddSubject(
                            id: "ATCBNN6",
                            name: "Tiếng Anh 3",
                            numberOfCredits: "4",
                          ));
                    },
                  ),
                ],
              ),
            ),
            // actions: <Widget>[
            //   ElevatedButton(
            //     child: Text('OK'),
            //     onPressed: () {},
            //   ),
            // ],
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
