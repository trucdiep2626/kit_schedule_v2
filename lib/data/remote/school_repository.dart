import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';
import 'package:kit_schedule_v2/data/api_constans.dart';
import 'package:kit_schedule_v2/domain/models/base_response.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';

class SchoolRepository {
  final HiveConfig hiveConfig;

  SchoolRepository(this.hiveConfig);

  Future<SchoolScheduleModel?> getSchoolSchedule({
    required String username,
    required String password,
  }) async {
    final BaseResponse baseResponse = await ApiClient.instance.request(
        path: ApiConstants.getSchedule,
        method: NetworkMethod.post,
        queryParameters: {"username": username, "password": password});
    if ((baseResponse.result ?? false) && baseResponse.data != null) {
      final schoolSchedule =
          SchoolScheduleModel.fromJson(json.decode(baseResponse.data)["data"]);
      return schoolSchedule;
    } else {
      return null;
    }
  }

  Future<StudentScores?> getScore({
    required String studentCode,
  }) async {
    final BaseResponse baseResponse = await ApiClient.instance.request(
      path: '${ApiConstants.getScores}$studentCode',
      method: NetworkMethod.get,
    );
    if ((baseResponse.result ?? false) && baseResponse.data != null) {
      debugPrint('========${baseResponse.data['data']}');
      final studentScores = StudentScores.fromJson(baseResponse.data['data']);
      return studentScores;
    } else {
      return null;
    }
  }

  Future<void> insertSchoolScheduleLocal(List<StudentSchedule> data) async {
    await hiveConfig.scheduleBox.addAll(data);
  }

  Future<List<StudentSchedule>> getSchoolScheduleLocal() async {
    final result = hiveConfig.scheduleBox.values.toList();
    //result.sort((a, b) => int.parse(a.date!).compareTo(int.parse(b.date!)));
    return result;
  }

  Future<void> setStudentInfoLocal(StudentInfo studentInfo) async {
    await hiveConfig.studentBox.put(HiveKey.studentInfoCollection, studentInfo);
  }

  StudentInfo? getStudentInfoLocal() {
    return hiveConfig.studentBox.get(HiveKey.studentInfoCollection);
  }

  // Future<void> deleteAllSchoolSchedulesLocal() async {
  //   await hiveConfig.scheduleBox.clear();
  //   debugPrint('Empty ? ' + hiveConfig.scheduleBox.isEmpty.toString());
  // }

  // Future<void> updateAllSchoolSchedulesRepo(List<SchoolSchedule> data) async {
  //   await hiveConfig.scheduleBox.addAll(data);
  //   debugPrint(
  //       'Schedule box length: ' + hiveConfig.scheduleBox.length.toString());
  //   int length = data.length;
  //   debugPrint('  length: ' + length.toString());
  //   while (length > 0) {
  //     await hiveConfig.scheduleBox.deleteAt(0);
  //     length--;
  //   }
  //   debugPrint(
  //       '>>>Schedule box length: ' + hiveConfig.scheduleBox.length.toString());
  // }

}
