import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';

part 'personal_schedule_model.g.dart';

@HiveType(typeId: HiveTypeConstants.personal)
class PersonalScheduleModel {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? timer;
  @HiveField(3)
  String? note;
  @HiveField(4)
  String? createAt;
  @HiveField(5)
  String? updateAt;
  @HiveField(6)
  bool? isSynchronized;
  @HiveField(7)
  String? id;

  PersonalScheduleModel(
      {this.date,
      this.name,
      this.timer,
      this.note,
      this.createAt,
      this.updateAt,
      this.isSynchronized,
      this.id}) {
    this.createAt =
        createAt ?? DateTime.now().millisecondsSinceEpoch.toString();
    this.updateAt =
        updateAt ?? DateTime.now().millisecondsSinceEpoch.toString();
  }

  PersonalScheduleModel.fromJson(Map<dynamic, dynamic> data, this.createAt) {
    this.date = data['date'];
    this.name = data['name'];
    this.timer = data['timer'];
    this.note = data['note'];
    this.createAt = data['createAt'];
    this.updateAt = data['updateAt'];
  }

  toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = this.date;
    data['name'] = this.name;
    data['timer'] = this.timer;
    data['note'] = this.note;
    data['createAt'] = this.createAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
