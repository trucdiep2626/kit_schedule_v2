import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/data/remote/score_respository.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';

class ScoreUseCase {
  final ScoreRepository scoreRepository;
  ScoreUseCase(this.scoreRepository);

  Future<void> insertScoreEng(HiveScoresCell HiveScoresCell) {
    return scoreRepository.insertScoreEng(HiveScoresCell);
  }
  Future<void> clearDataScore() async{
    await scoreRepository.clearDataScore();
  }
  Future<void> insertSubjectFromAPI(StudentScores studentScores, int index) {
    return scoreRepository.insertSubjectFromAPI(studentScores, index);
  }

  bool isDuplicate(StudentScores studentScores, int index) {
    return scoreRepository.isDuplicate(studentScores, index);
  }

  Future<void> delSubject(int index) {
    return scoreRepository.delSubject(index);
  }

  int getLengthHiveScoresCell() {
    return scoreRepository.getLengthHiveScoresCell();
  }

  Future<StudentScores?> getScoresStudents({required String studentCode}) {
    return scoreRepository.getScoresStudents(studentCode: studentCode);
  }

  double? calAvgScore(
      {required String? firstComponentScore,
      required String? secondComponentScore,
      required String? examScore}) {
    return scoreRepository.calAvgScore(
        firstComponentScore: firstComponentScore,
        secondComponentScore: secondComponentScore,
        examScore: examScore);
  }

  double? avgScoresCell() {
    return scoreRepository.avgScoresCell();
  }

  int calNoPassedSubjects() {
    return scoreRepository.calNoPassedSubjects();
  }

  int calPassedSubjects() {
    return scoreRepository.calPassedSubjects();
  }

  String? calAlphabetScore(
      {required String? firstComponentScore,
      required String? secondComponentScore,
      required String? examScore}) {
    return scoreRepository.calAlphabetScore(
        firstComponentScore: firstComponentScore,
        secondComponentScore: secondComponentScore,
        examScore: examScore);
  }

  double calSumScoresCell() {
    return scoreRepository.calSumScoresCell();
  }

  double calTotalCredits() {
    return scoreRepository.calTotalCredits();
  }

  double calScorePointSystem4(String? alphabetScore) {
    return scoreRepository.calScorePointSystem4(alphabetScore);
  }
}
