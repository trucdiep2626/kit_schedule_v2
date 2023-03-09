import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/config/network/api_client.dart';
import 'package:kit_schedule_v2/common/config/network/api_endpoints.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/usecases/score_usecase.dart';

import '../../domain/models/hive_score_cell.dart';

class ScoreRepository {
  final HiveConfig hiveConfig;
  ScoreRepository(this.hiveConfig);
  Future<void> insertScoreEng(HiveScoresCell HiveScoresCell) async {
    await hiveConfig.hiveScoresCell.add(HiveScoresCell);
  }

  Future<void> insertSubjectFromAPI(
      StudentScores studentScores, int index, bool isLocal) async {
    studentScores.scores != null
        ? await hiveConfig.hiveScoresCell.add(
            HiveScoresCell(
              alphabetScore: studentScores.scores?[index].alphabetScore,
              examScore: studentScores.scores?[index].examScore,
              firstComponentScore:
                  studentScores.scores?[index].firstComponentScore,
              secondComponentScore:
                  studentScores.scores?[index].secondComponentScore,
              avgScore: studentScores.scores?[index].avgScore,
              id: studentScores.scores?[index].subject?.id,
              name: studentScores.scores?[index].subject?.name,
              numberOfCredits:
                  studentScores.scores?[index].subject?.numberOfCredits,
              isLocal: isLocal,
            ),
          )
        : '';
  }

  Future<void> insertScoreIntoHive(StudentScores? studentScores,
      ScoreUseCase scoreUseCase, List<bool?> isLocal) async {
    if (studentScores != null) {
      studentScores.scores?.length = scoreUseCase.getLengthHiveScoresCell();
      studentScores.avgScore = scoreUseCase.avgScoresCell();
      studentScores.passedSubjects = scoreUseCase.calPassedSubjects();
      studentScores.failedSubjects = scoreUseCase.calNoPassedSubjects();

      for (int index = 0;
          index < scoreUseCase.getLengthHiveScoresCell();
          index++) {
        isLocal.add(scoreUseCase.getIsLocal(index));
        studentScores.scores?[index].subject?.name =
            scoreUseCase.getName(index);
        studentScores.scores?[index].subject?.id = scoreUseCase.getID(index);
        studentScores.scores?[index].subject?.numberOfCredits =
            scoreUseCase.getNumberOfCredits(index);
        studentScores.scores?[index].firstComponentScore =
            scoreUseCase.getFirstComponentScore(index);
        studentScores.scores?[index].secondComponentScore =
            scoreUseCase.getSecondComponentScore(index);
        studentScores.scores?[index].examScore =
            scoreUseCase.getExamScore(index);
        studentScores.scores?[index].avgScore = scoreUseCase.getAvgScore(index);
        studentScores.scores?[index].alphabetScore =
            scoreUseCase.getAlphabetScore(index);
      }
    }
  }

  bool compareToId(int i, String id) {
    if (hiveConfig.hiveScoresCell.values.elementAt(i).id == id) return true;
    return false;
  }

  bool compareToName(int i, String name) {
    if (hiveConfig.hiveScoresCell.values
            .elementAt(i)
            .name
            ?.toLowerCase()
            .compareTo(name.toLowerCase()) ==
        0) return true;
    return false;
  }

  String? getName(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.name;
  }

  String? getID(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.id;
  }

  String? getAlphabetScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.alphabetScore;
  }

  bool? getIsLocal(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.isLocal;
  }

  int? getNumberOfCredits(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.numberOfCredits;
  }

  String? getFirstComponentScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.firstComponentScore;
  }

  String? getSecondComponentScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.secondComponentScore;
  }

  String? getExamScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.examScore;
  }

  String? getAvgScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)?.avgScore;
  }

  Future<void> clearDataScore() async {
    await hiveConfig.hiveScoresCell.clear();
  }

  Future<StudentScores?> getScoresStudents({
    required String studentCode,
  }) async {
    final result =
        await ApiClient.getRequest('${ApiEndpoints.getScores}$studentCode');
    if (result is Map<String, dynamic>) {
      final scoresCells = StudentScores.fromJson(result);
      return scoresCells;
    } else {
      return null;
    }
  }

  bool isDuplicate(StudentScores result, int index) {
    if (hiveConfig.hiveScoresCell.values
        .where((element) => element.id == result.scores?[index].subject?.id)
        .isEmpty) {
      return true;
    }
    return false;
  }

  double? calAvgScore(
      {required String? firstComponentScore,
      required String? secondComponentScore,
      required String? examScore}) {
    return (double.parse(firstComponentScore ?? '0') * 0.7 +
                double.parse(secondComponentScore ?? '0') * 0.3) *
            0.3 +
        double.parse(examScore ?? '0') * 0.7;
  }

  double? avgScoresCell() {
    return (calSumScoresCell() / calTotalCredits());
  }

  int calNoPassedSubjects() {
    return hiveConfig.hiveScoresCell.length - calPassedSubjects();
  }

  int calPassedSubjects() {
    int calPassedSubjects = 0;

    for (int i = 0; i < hiveConfig.hiveScoresCell.length; i++) {
      if (isNumeric(hiveConfig.hiveScoresCell.getAt(i)?.examScore!) &&
          isNumeric(hiveConfig.hiveScoresCell.getAt(i)?.avgScore!)) {
        if ((double.parse(
                        hiveConfig.hiveScoresCell.getAt(i)?.examScore ?? "0") >=
                    4 &&
                double.parse(
                        hiveConfig.hiveScoresCell.getAt(i)?.examScore ?? '0') <=
                    10) &&
            (double.parse(
                        hiveConfig.hiveScoresCell.getAt(i)?.avgScore ?? '0') >=
                    4 &&
                double.parse(
                        hiveConfig.hiveScoresCell.getAt(i)?.avgScore ?? '0') <=
                    10)) {
          calPassedSubjects = calPassedSubjects + 1;
        } else {
          continue;
        }
      }
    }
    return calPassedSubjects;
  }

  String? calAlphabetScore(
      {required String? firstComponentScore,
      required String? secondComponentScore,
      required String? examScore}) {
    final avgScore = calAvgScore(
            firstComponentScore: firstComponentScore,
            secondComponentScore: secondComponentScore,
            examScore: examScore)
        .toString();
    return Convert.scoreConvert(double.parse(avgScore));
  }

  Future<void> delSubject(int index) {
    return hiveConfig.hiveScoresCell.deleteAt(index);
  }

  int getLengthHiveScoresCell() {
    return hiveConfig.hiveScoresCell.length;
  }

  double calTotalCredits() {
    double totalCredits = 0;

    for (int i = 0; i < hiveConfig.hiveScoresCell.length; i++) {
      if (getID(i) == "ATQGTC1" ||
          getID(i) == "ATQGTC2" ||
          getID(i) == "ATQGTC3" ||
          getID(i) == "ATQGTC4" ||
          getID(i) == "ATQGTC5") {
        continue;
      } else {
        totalCredits +=
            hiveConfig.hiveScoresCell.getAt(i)?.numberOfCredits ?? 0;
      }
    }
    return totalCredits;
  }

  double calSumScoresCell() {
    double sumSCoresCell = 0;
    for (int i = 0; i < hiveConfig.hiveScoresCell.length; i++) {
      if (getID(i) == "ATQGTC1" ||
          getID(i) == "ATQGTC2" ||
          getID(i) == "ATQGTC3" ||
          getID(i) == "ATQGTC4" ||
          getID(i) == "ATQGTC5") {
        continue;
      } else {
        if (hiveConfig.hiveScoresCell.getAt(i) != null) {
          sumSCoresCell += (Convert.letterScoreConvert(
                  hiveConfig.hiveScoresCell.getAt(i)?.alphabetScore) *
              hiveConfig.hiveScoresCell.getAt(i)!.numberOfCredits!);
        }
      }
    }
    return sumSCoresCell;
  }

  List<HiveScoresCell> getHiveScoresCell() {
    return hiveConfig.hiveScoresCell.values.toList();
  }

  Box<HiveScoresCell> getHiveScoresCellBox() {
    return hiveConfig.hiveScoresCell;
  }
}
