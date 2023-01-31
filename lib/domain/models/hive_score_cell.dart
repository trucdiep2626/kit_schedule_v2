import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';
part 'hive_score_cell.g.dart';

@HiveType(typeId: HiveTypeConstants.scoresCell)
class HiveScoresCell {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? id;
  @HiveField(2)
  int? numberOfCredits;
  @HiveField(3)
  String? firstComponentScore;
  @HiveField(4)
  String? secondComponentScore;
  @HiveField(5)
  String? examScore;
  @HiveField(6)
  String? avgScore;
  @HiveField(7)
  String? alphabetScore;
  HiveScoresCell({
    this.name,
    this.id,
    this.numberOfCredits,
    this.firstComponentScore,
    this.alphabetScore,
    this.avgScore,
    this.examScore,
    this.secondComponentScore,
  });
  HiveScoresCell.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    numberOfCredits = json['numberOfCredits'];
    firstComponentScore = json['firstComponentScore'];
    secondComponentScore = json['secondComponentScore'];
    examScore = json['examScore'];
    avgScore = json['avgScore'];
    alphabetScore = json['alphabetScore'];
  }
  toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['id'] = this.id;
    data['numberOfCredits'] = this.numberOfCredits;
    data['firstComponentScore'] = this.firstComponentScore;
    data['secondComponentScore'] = this.secondComponentScore;
    data['examScore'] = this.examScore;
    data['avgScore'] = this.avgScore;
    data['alphabetScore'] = this.alphabetScore;
    return data;
  }
}
class ScoreCell{
  
}

  

  