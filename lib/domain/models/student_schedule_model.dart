import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';

part 'student_schedule_model.g.dart';

@HiveType(typeId: HiveTypeConstants.school)
class StudentSchedule {
  @HiveField(0)
  String? day;
  @HiveField(1)
  String? subjectCode;
  @HiveField(2)
  String? subjectName;
  @HiveField(3)
  String? className;
  @HiveField(4)
  String? teacher;
  @HiveField(5)
  String? lesson;
  @HiveField(6)
  String? room;

  StudentSchedule(
      {this.day,
        this.subjectCode,
        this.subjectName,
        this.className,
        this.teacher,
        this.lesson,
        this.room});

  StudentSchedule.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    subjectCode = json['subjectCode'];
    subjectName = json['subjectName'];
    className = json['className'];
    teacher = json['teacher'];
    lesson = json['lesson'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['subjectCode'] = subjectCode;
    data['subjectName'] = subjectName;
    data['className'] = className;
    data['teacher'] = teacher;
    data['lesson'] = lesson;
    data['room'] = room;
    return data;
  }
}