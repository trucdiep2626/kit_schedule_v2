import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/network/network_state.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/score_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/widgets/snack_bar/app_snack_bar.dart';
import 'package:kit_schedule_v2/presentation/widgets/text_input_dialog.dart';

import 'components/navigator_add_subject.dart';

class ScoreController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  final SchoolUseCase schoolUseCase;
  final ScoreUseCase scoreUseCase;
  late final GlobalKey<RefreshIndicatorState> refreshKey;

  Rx<StudentScores?> rxStudentScores = (null as StudentScores?).obs;
  RxList<bool> rxExpandedList = <bool>[].obs;

  ScoreController(this.schoolUseCase, this.scoreUseCase);

  TextEditingController firstComponentScore = TextEditingController();
  TextEditingController secondComponentScore = TextEditingController();
  TextEditingController examScore = TextEditingController();
  RxString validateFirstComponentScore = ''.obs;
  RxString validateSecondComponentScore = ''.obs;
  RxString validateExamScore = ''.obs;

  Future<void> onRefresh(bool isAdd) async {
    if (!await NetworkState.isConnected) {
      showTopSnackBar(context,
          message: 'Không có kết nối Internet', type: SnackBarType.error);
      return;
    }
    rxLoadedType.value = LoadedType.start;
    await getScores(isAdd);
    rxLoadedType.value = LoadedType.finish;
  }

  Future<void> getScores(bool isAdd) async {
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
      rxStudentScores.value = result;
      if (!isAdd) {
        scoreUseCase.insertScoreIntoHive(rxStudentScores, scoreUseCase);
      }
      if (!isNullEmpty(result)) {
        rxExpandedList.value = List.generate(
            rxStudentScores.value!.scores!.length, (index) => false);
      }
      if (!isNullEmpty(result)) {
        for (int index = 0; index < result!.scores!.length; index++) {
          if (result.scores![index].subject!.id!.contains("ATQGTC1") ||
              result.scores![index].subject!.id!.contains("ATQGTC2") ||
              result.scores![index].subject!.id!.contains("ATQGTC3") ||
              result.scores![index].subject!.id!.contains("ATQGTC4") ||
              result.scores![index].subject!.id!.contains("ATQGTC5")) {
            continue;
          } else {
            if (scoreUseCase.isDuplicate(result, index)) {
              scoreUseCase.insertSubjectFromAPI(result, index);
            }
          }
        }
      }
      if (isAdd) {
        scoreUseCase.insertScoreIntoHive(rxStudentScores, scoreUseCase);
      }

      if (isExist("ATCBNN1") && isExist("LTCBNN2") && isExist("ATCBNN6")) {
        Future.delayed(const Duration(seconds: 1), () async {
          showTopSnackBar(context,
              message: "Số môn học trong bảng điểm đã đủ",
              type: SnackBarType.warning);
        });
      }
    } catch (e) {
      showTopSnackBar(
        Get.context!,
        message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
        type: SnackBarType.error,
      );
      rethrow;
    }
    rxLoadedType.value = LoadedType.finish;
  }

  void resetData() {
    firstComponentScore.clear();
    secondComponentScore.clear();
    examScore.clear();
    validateExamScore.value = '';
    validateFirstComponentScore.value = '';
    validateSecondComponentScore.value = '';
  }

  bool checkValidateFirstComponentScore() {
    try {
      if (double.parse(firstComponentScore.text.trim()) > 10) {
        validateFirstComponentScore.value = "Vui lòng nhập điểm <=10";
        return false;
      }
    } catch (e) {
      showTopSnackBar(context,
          message: "Vui lòng điền đủ các trường", type: SnackBarType.error);
    }
    return true;
  }

  bool checkValidateSecondComponentScore() {
    try {
      if (double.parse(secondComponentScore.text.trim()) > 10) {
        validateSecondComponentScore.value = "Vui lòng nhập điểm <=10";
        return false;
      }
    } catch (e) {
      showTopSnackBar(context,
          message: "Vui lòng điền đủ các trường", type: SnackBarType.error);
    }
    return true;
  }

  bool checkValidateExamScore() {
    try {
      if (double.parse(examScore.text.trim()) > 10) {
        validateExamScore.value = "Vui lòng nhập điểm <=10";
        return false;
      }
    } catch (e) {
      showTopSnackBar(context,
          message: "Vui lòng điền đủ các trường", type: SnackBarType.error);
    }
    return true;
  }

  Future<void> insertScoreIntoHive(bool isAdd) async {
    if (isAdd) {
      scoreUseCase.insertScoreIntoHive(rxStudentScores, scoreUseCase);
    }
  }

  Future<void> delSubject(int index) async {
    await scoreUseCase.delSubject(index);
    await onRefresh(false);
  }

  bool isExist(String name) {
    int n = 0;
    for (int i = 0; i < scoreUseCase.getLengthHiveScoresCell(); i++) {
      if (scoreUseCase.compareToName(i, name)) {
        n++;
      }
    }
    if (n != 0) {
      return true;
    }
    return false;
  }

  Future<void> addScoreEng(
      String? name, String? id, String? numberOfCredits) async {
    if (!checkValidateFirstComponentScore()) {
      return;
    } else if (!checkValidateSecondComponentScore()) {
      return;
    } else if (!checkValidateExamScore()) {
      return;
    }

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
              .toStringAsFixed(1),
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
      resetData();
      Get.close(2);
      await onRefresh(false);
    } catch (e) {
      showTopSnackBar(context,
          message: 'Các trường phải được điền chính xác và không được bỏ trống',
          type: SnackBarType.error);
    }
  }

  Function() onPressedAddSubject(
      {required String name,
      required String id,
      required String numberOfCredits}) {
    return () {
      if (!isExist(id)) {
        return () {
          Get.to(
            () => NavigatorAddSubject(
              id: id,
              name: name,
              numberOfCredits: numberOfCredits,
            ),
          );
        };
      }
    };
  }

  Function(int?) onSelectedAddSubject() {
    return (value) {
      if (value == 1) {
        displayTextInputDialog(
          compareIdEnd1: !isExist('Tiếng anh 1'),
          compareIdEnd2: !isExist('Tiếng anh 2'),
          compareIdEnd3: !isExist('Tiếng anh 3'),
          Get.context!,
          onPressedEng1: onPressedAddSubject(
            name: "Tiếng Anh 1",
            id: 'ATCBNN1',
            numberOfCredits: '3',
          )(),
          onPressedEng2: onPressedAddSubject(
              name: "Tiếng Anh 2",
              id: 'LTCBNN2', // Mã môn không đồng nhất giữa các năm!!!
              numberOfCredits: '3')(),
          onPressedEng3: onPressedAddSubject(
            name: "Tiếng Anh 3",
            id: 'ATCBNN6',
            numberOfCredits: '4',
          )(),
        );
      }
    };
  }

  Function(int?) onSelectedDelSubject(int index) {
    return (value) {
      if (value == 1) {
        showTopSnackBar(
          Get.context!,
          message: 'Xóa môn học thành công',
          type: SnackBarType.done,
        );
        delSubject(index);
      }
    };
  }

  void onPressRefresh() async {
    refreshKey.currentState?.show();
    await onRefresh(true);
    showTopSnackBar(context,
        message: "Cập nhật điểm thành công", type: SnackBarType.done);
  }

  Function() onTapBackScorePage() {
    return () {
      Get.back();
      resetData();
    };
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    onRefresh(true);
  }

  @override
  void onInit() {
    super.onInit();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  void setExpandedCell(int index, bool expanded) {
    rxExpandedList.fillRange(0, rxExpandedList.length, false);
    rxExpandedList[index] = !expanded;
  }
}
