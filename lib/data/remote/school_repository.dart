import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/data/api_constans.dart';
import 'package:kit_schedule_v2/domain/models/base_response.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';

class SchoolRepository {
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
}
