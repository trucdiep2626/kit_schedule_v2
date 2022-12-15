
import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';

part 'personal_schedule_model.g.dart';

@HiveType(typeId: HiveTypeConstants.personal)
class PersonalScheduleModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? timer;
  @HiveField(4)
  String? note;

  PersonalScheduleModel(this.date, this.name, this.timer, this.note, {this.id});

  PersonalScheduleModel.fromJson(Map<String, dynamic> data) {
    id = data['id'].toString();
    date = data['date'];
    note = data['note'];
    name = data['schedule_name'];
    timer = data['timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['date'] = date;
    data['schedule_name'] = name;
    data['timer'] = timer;
    return data;
  }
}
