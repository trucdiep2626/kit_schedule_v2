import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';


part 'student_info_model.g.dart';

@HiveType(typeId: HiveTypeConstants.student)
class StudentInfo {
  @HiveField(0)
  String? displayName;
  @HiveField(1)
  String? studentCode;
  @HiveField(2)
  String? gender;
  @HiveField(3)
  String? birthday;

  StudentInfo({this.displayName, this.studentCode, this.gender, this.birthday});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    studentCode = json['studentCode'];
    gender = json['gender'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['studentCode'] = studentCode;
    data['gender'] = gender;
    data['birthday'] = birthday;
    return data;
  }

  @override
  String toString() {
    return 'StudentInfo{displayName: $displayName, studentCode: $studentCode, gender: $gender, birthday: $birthday}';
  }
}