import 'package:kit_schedule_v2/data/remote/school_repository.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';

class SchoolUseCase {
  final SchoolRepository schoolRepository;

  SchoolUseCase({required this.schoolRepository});

  Future<SchoolScheduleModel?> getSchoolSchedule({
    required String username,
    required String password,
  }) async {
    return schoolRepository.getSchoolSchedule(
        username: username, password: password);
  }

  Future<StudentScores?> getScore({
    required String studentCode,
  }) async {
    return schoolRepository.getScore(studentCode: studentCode);
  }
}
