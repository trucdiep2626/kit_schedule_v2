import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/config/network/api_client.dart';
import 'package:kit_schedule_v2/common/config/network/api_endpoints.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';

import '../../domain/models/hive_score_cell.dart';

class ScoreRepository {
  final HiveConfig hiveConfig;
  ScoreRepository(this.hiveConfig);

  Future<void> insertScoreEng(
      String avgScore,
      String name,
      String id,
      int numberOfCredits,
      String alphabetScore,
      String examScore,
      String firstComponentScore,
      String secondComponentScore) async {
    await hiveConfig.hiveScoresCell.add(
      HiveScoresCell(
        alphabetScore: alphabetScore,
        examScore: examScore,
        firstComponentScore: firstComponentScore,
        secondComponentScore: secondComponentScore,
        avgScore: avgScore,
        id: id,
        name: name,
        numberOfCredits: numberOfCredits,
      ),
    );
  }

  Future<Score?> getScore({
    required String studentCode,
  }) async {
    final result =
        await ApiClient.getRequest('${ApiEndpoints.getScores}$studentCode');
    if (result is Map<String, dynamic>) {
      final scoresCells = Score.fromJson(result);
      return scoresCells;
    } else {
      return null;
    }
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

  // Future<Subject?> getSubJect({
  //   required String studentCode,
  // }) async {
  //   final result =
  //       await ApiClient.getRequest('${ApiEndpoints.getScores}$studentCode');
  //   if (result is Map<String, dynamic>) {
  //     final subjectCells = Subject.fromJson(result);
  //     return subjectCells;
  //   } else {
  //     return null;
  //   }
  // }
  // ignore: body_might_complete_normally_nullable
  bool? checkDuplicate(StudentScores result, int index) {
    hiveConfig.hiveScoresCell.values.where((element) {
      if (element.id == result.scores![index].subject!.id) {
        return true;
      }
      return false;
    });
  }

  double? calAvgScore(HiveScoresCell hiveScoresCell) {
    return (double.parse(hiveScoresCell.firstComponentScore!) * 0.7 +
                double.parse(hiveScoresCell.secondComponentScore!) * 0.3) *
            0.3 +
        double.parse(hiveScoresCell.examScore!) * 0.7;
  }

  double? avgScoresCell() {
    return (calSumScoresCell() / calTotalCredits());
  }

  String? calAlphabetScore(HiveScoresCell hiveScoresCell) {
    hiveScoresCell.avgScore = calAvgScore(hiveScoresCell).toString();
    if (double.parse(hiveScoresCell.avgScore!) >= 0.0 &&
        double.parse(hiveScoresCell.avgScore!) < 4.0) {
      return 'F';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 4.0 &&
        double.parse(hiveScoresCell.avgScore!) < 4.8) {
      return 'D';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 4.8 &&
        double.parse(hiveScoresCell.avgScore!) < 5.5) {
      return 'D+';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 5.5 &&
        double.parse(hiveScoresCell.avgScore!) < 6.3) {
      return 'C';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 6.3 &&
        double.parse(hiveScoresCell.avgScore!) < 7.0) {
      return 'C+';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 7.0 &&
        double.parse(hiveScoresCell.avgScore!) < 7.8) {
      return 'B';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 7.8 &&
        double.parse(hiveScoresCell.avgScore!) < 8.5) {
      return 'B+';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 8.5 &&
        double.parse(hiveScoresCell.avgScore!) < 9) {
      return 'A';
    } else if (double.parse(hiveScoresCell.avgScore!) >= 9 &&
        double.parse(hiveScoresCell.avgScore!) <= 10) {
      return 'A+';
    }
    return 'F';
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

  double calTotalCredits() {
    double totalCredits = 0;
    for (int i = 0; i < hiveConfig.hiveScoresCell.length; i++) {
      totalCredits += hiveConfig.hiveScoresCell.getAt(i)!.numberOfCredits!;
    }
    return totalCredits;
  }

  double calSumScoresCell() {
    double sumSCoresCell = 0;
    for (int i = 0; i < hiveConfig.hiveScoresCell.length; i++) {
      sumSCoresCell += (calScorePointSystem4(
              hiveConfig.hiveScoresCell.getAt(i)!.alphabetScore!) *
          hiveConfig.hiveScoresCell.getAt(i)!.numberOfCredits!);
    }
    return sumSCoresCell;
  }

  Future<void> deleteScoreCell(HiveScoresCell hiveScoresCell) async {
    await hiveConfig.hiveScoresCell.deleteAt(indexOfScoreCell(hiveScoresCell));
  }

  int indexOfScoreCell(HiveScoresCell hiveScoresCell) {
    return hiveConfig.hiveScoresCell.values.toList().indexOf(hiveScoresCell);
  }

  // Future<void> editScoreCell(HiveScoresCell hiveScoresCell, HiveScoresCell newHiveScoresCell) async{
  //   await hiveConfig.hiveScoresCell.putAt(indexOfScoreCell(hiveScoresCell), newHiveScoresCell);
  // }
  Future<void> insertScoreCell(Score score, Subject subject) async {
    await hiveConfig.hiveScoresCell.add(HiveScoresCell(
      name: subject.name,
      id: subject.id,
      numberOfCredits: subject.numberOfCredits,
      alphabetScore: score.alphabetScore,
      avgScore: score.avgScore,
      examScore: score.examScore,
      firstComponentScore: score.firstComponentScore,
      secondComponentScore: score.secondComponentScore,
    ));
  }
}
