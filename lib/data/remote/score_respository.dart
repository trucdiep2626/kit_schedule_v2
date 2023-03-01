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
      StudentScores studentScores, int index) async {
    studentScores.scores != null
        ? await hiveConfig.hiveScoresCell.add(
            HiveScoresCell(
              alphabetScore: studentScores.scores![index].alphabetScore,
              examScore: studentScores.scores![index].examScore,
              firstComponentScore:
                  studentScores.scores![index].firstComponentScore,
              secondComponentScore:
                  studentScores.scores![index].secondComponentScore,
              avgScore: studentScores.scores![index].avgScore,
              id: studentScores.scores![index].subject!.id,
              name: studentScores.scores![index].subject!.name,
              numberOfCredits:
                  studentScores.scores![index].subject!.numberOfCredits,
            ),
          )
        : '';
  }

  Future<void> insertScoreIntoHive(Rx<StudentScores?> rxStudentScores) async {
    rxStudentScores.value!.scores!.length = getLengthHiveScoresCell();
    rxStudentScores.value!.avgScore = avgScoresCell();
    rxStudentScores.value!.passedSubjects = calPassedSubjects();
    rxStudentScores.value!.failedSubjects = calNoPassedSubjects();
    for (int index = 0; index < getLengthHiveScoresCell(); index++) {
      rxStudentScores.value!.scores![index].subject!.name = getName(index);
      rxStudentScores.value!.scores![index].subject!.id = getID(index);
      rxStudentScores.value!.scores![index].subject!.numberOfCredits =
          getNumberOfCredits(index);
      rxStudentScores.value!.scores![index].firstComponentScore =
          getFirstComponentScore(index);
      rxStudentScores.value!.scores![index].secondComponentScore =
          getSecondComponentScore(index);
      rxStudentScores.value!.scores![index].examScore = getExamScore(index);
      rxStudentScores.value!.scores![index].avgScore = getAvgScore(index);
      rxStudentScores.value!.scores![index].alphabetScore =
          getAlphabetScore(index);
    }
  }

  bool compareToName(int i, String name) {
    if (hiveConfig.hiveScoresCell.values.elementAt(i).name == name) return true;
    return false;
  }

  String? getName(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.name;
  }

  String? getID(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.id;
  }

  String? getAlphabetScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.alphabetScore;
  }

  int? getNumberOfCredits(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.numberOfCredits;
  }

  String? getFirstComponentScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.firstComponentScore;
  }

  String? getSecondComponentScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.secondComponentScore;
  }

  String? getExamScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.examScore;
  }

  String? getAvgScore(int index) {
    return hiveConfig.hiveScoresCell.getAt(index)!.avgScore;
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
        .where((element) => element.id == result.scores![index].subject!.id)
        .isEmpty) {
      return true;
    }
    return false;
  }

  double? calAvgScore(
      {required String? firstComponentScore,
      required String? secondComponentScore,
      required String? examScore}) {
    return (double.parse(firstComponentScore!) * 0.7 +
                double.parse(secondComponentScore!) * 0.3) *
            0.3 +
        double.parse(examScore!) * 0.7;
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
      if (isNumeric(hiveConfig.hiveScoresCell.getAt(i)!.examScore!) &&
          isNumeric(hiveConfig.hiveScoresCell.getAt(i)!.avgScore!)) {
        if ((double.parse(hiveConfig.hiveScoresCell.getAt(i)!.examScore!) >=
                    4 &&
                double.parse(hiveConfig.hiveScoresCell.getAt(i)!.examScore!) <=
                    10) &&
            (double.parse(hiveConfig.hiveScoresCell.getAt(i)!.avgScore!) >= 4 &&
                double.parse(hiveConfig.hiveScoresCell.getAt(i)!.avgScore!) <=
                    10)) {
          calPassedSubjects = calPassedSubjects + 1;
        } else {
          i++;
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

  double calScorePointSystem4(String? alphabetScore) {
    if (alphabetScore == 'F') {
      return 0.0;
    } else if (alphabetScore == 'D') {
      return 1.0;
    } else if (alphabetScore == 'D+') {
      return 1.5;
    } else if (alphabetScore == 'C') {
      return 2.0;
    } else if (alphabetScore == 'C+') {
      return 2.5;
    } else if (alphabetScore == 'B') {
      return 3.0;
    } else if (alphabetScore == 'B+') {
      return 3.5;
    } else if (alphabetScore == 'A') {
      return 3.8;
    } else if (alphabetScore == 'A+') {
      return 4.0;
    }
    return 0.0;
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
      hiveConfig.hiveScoresCell.getAt(i)!.numberOfCredits != null
          ? totalCredits += hiveConfig.hiveScoresCell.getAt(i)!.numberOfCredits!
          : 0;
    }
    return totalCredits;
  }

  double calSumScoresCell() {
    double sumSCoresCell = 0;
    for (int i = 0; i < hiveConfig.hiveScoresCell.length; i++) {
      hiveConfig.hiveScoresCell.getAt(i)!.alphabetScore != null
          ? sumSCoresCell += (calScorePointSystem4(
                  hiveConfig.hiveScoresCell.getAt(i)!.alphabetScore) *
              hiveConfig.hiveScoresCell.getAt(i)!.numberOfCredits!)
          : 0;
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
