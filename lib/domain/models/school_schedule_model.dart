import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';

class SchoolScheduleModel {
  StudentInfo? studentInfo;
  List<StudentSchedule>? studentSchedule;

  SchoolScheduleModel({this.studentInfo, this.studentSchedule});

  SchoolScheduleModel.fromJson(Map<String, dynamic> json) {
    studentInfo = json['studentInfo'] != null
        ? StudentInfo.fromJson(json['studentInfo'])
        : null;
    if (json['studentSchedule'] != null) {
      studentSchedule = <StudentSchedule>[];
      json['studentSchedule'].forEach((v) {
        studentSchedule!.add(StudentSchedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentInfo != null) {
      data['studentInfo'] = studentInfo!.toJson();
    }
    if (studentSchedule != null) {
      data['studentSchedule'] =
          studentSchedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SchoolScheduleModel{studentInfo: $studentInfo}';
  }
}






