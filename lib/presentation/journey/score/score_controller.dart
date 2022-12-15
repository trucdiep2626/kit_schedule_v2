import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScoreController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxScoreLoadedType = LoadedType.finish.obs;
  SchoolUseCase schoolUseCase;
  Rx<StudentScores?> studentScores = (null as StudentScores?).obs;

  late RefreshController scoreRefreshController;
  ScoreController(this.schoolUseCase);

  Future<void> onRefresh() async {
    rxScoreLoadedType.value = LoadedType.start;
    await getScores();
    scoreRefreshController.refreshCompleted();
    rxScoreLoadedType.value = LoadedType.finish;
  }

  Future<void> getScores() async {
    rxScoreLoadedType.value = LoadedType.start;

    final studentCode = Get.find<MainController>()
        .schoolScheduleModel
        .value
        .studentInfo
        ?.studentCode;

    if (studentCode == null || studentCode.isEmpty) {
      return;
    }

    try {
      final result = await schoolUseCase.getScore(studentCode: studentCode);
      debugPrint('===============$result');

      if (!isNullEmpty(result)) {
        studentScores.value = result!;
      }
    } catch (e) {}
    rxScoreLoadedType.value = LoadedType.finish;
  }

  @override
  void onInit() {
    super.onInit();
    scoreRefreshController = RefreshController(initialRefresh: false);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getScores();
  }
}
