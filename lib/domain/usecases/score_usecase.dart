import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schedule/data/remote/score_respository.dart';
import 'package:schedule/domain/models/hive_score_cell.dart';
import 'package:schedule/domain/models/score_model.dart';

class ScoreUseCase {
  final ScoreRepository scoreRepository;
  ScoreUseCase(this.scoreRepository);

  Future<void> insertScoreEng(HiveScoresCell HiveScoresCell) {
    return scoreRepository.insertScoreEng(HiveScoresCell);
  }

  Future<void> clearDataScore() async {
    await scoreRepository.clearDataScore();
  }

  Future<void> insertSubjectFromAPI(
      StudentScores studentScores, int index, bool isLocal, bool isSemester) {
    return scoreRepository.insertSubjectFromAPI(
        studentScores, index, isLocal, isSemester);
  }

  bool isDuplicate(StudentScores studentScores, int index) {
    return scoreRepository.isDuplicate(studentScores, index);
  }

  bool compareToId(int i, String id) {
    return scoreRepository.compareToId(i, id);
  }

  bool? getIsLocal(int index) {
    return scoreRepository.getIsLocal(index);
  }

  bool? getIsSemester(int index) {
    return scoreRepository.getIsSemester(index);
  }

  bool compareToName(int i, String name) {
    return scoreRepository.compareToName(i, name);
  }

  Future<void> delSubject(int index) {
    return scoreRepository.delSubject(index);
  }

  String? getName(int index) {
    return scoreRepository.getName(index);
  }

  String? getID(int index) {
    return scoreRepository.getID(index);
  }

  int? getNumberOfCredits(int index) {
    return scoreRepository.getNumberOfCredits(index);
  }

  double? calAvgSemester() {
    return scoreRepository.calAvgSemester();
  }

  String? calScholarshipScore(double score) {
    return scoreRepository.calScholarshipScore(score);
  }

  String? getAlphabetScore(int index) {
    return scoreRepository.getAlphabetScore(index);
  }

  Future<void>? putIsSemester(int index, HiveScoresCell HiveScoresCell) {
    return scoreRepository.putIsSemester(index, HiveScoresCell);
  }

  Future<void> insertScoreIntoHive(StudentScores? studentScores,
      ScoreUseCase scoreUseCase, List<bool?> isLocal, List<bool?> isSemester) {
    return scoreRepository.insertScoreIntoHive(
        studentScores, scoreUseCase, isLocal, isSemester);
  }

  String? getFirstComponentScore(int index) {
    return scoreRepository.getFirstComponentScore(index);
  }

  String? getSecondComponentScore(int index) {
    return scoreRepository.getSecondComponentScore(index);
  }

  String? getExamScore(int index) {
    return scoreRepository.getExamScore(index);
  }

  String? getAvgScore(int index) {
    return scoreRepository.getAvgScore(index);
  }

  int getLengthHiveScoresCell() {
    return scoreRepository.getLengthHiveScoresCell();
  }

  List<HiveScoresCell> getHiveScoresCell() {
    return scoreRepository.getHiveScoresCell();
  }

  Box<HiveScoresCell> getHiveScoresCellBox() {
    return scoreRepository.getHiveScoresCellBox();
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

  bool get localDataExist => scoreRepository.getHiveScoresCell().isNotEmpty;
}
