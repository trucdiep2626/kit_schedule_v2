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

class StudentInfo {
  String? displayName;
  String? studentCode;
  String? gender;
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

class StudentSchedule {
  String? day;
  String? subjectCode;
  String? subjectName;
  String? className;
  String? teacher;
  String? lesson;
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
