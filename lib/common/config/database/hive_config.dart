import 'package:hive/hive.dart';
import 'package:kit_schedule_v2/common/config/database/hive_type_constants.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_info_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
class LocalConfig {
  late Box<PersonalScheduleModel> personalBox;
  late Box<StudentSchedule> scheduleBox;
  late Box<StudentInfo> studentBox;

  Future<void> init() async {
    final appDocumentDirectory =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(PersonalScheduleModelAdapter());
    Hive.registerAdapter(StudentScheduleAdapter());
    Hive.registerAdapter(StudentInfoAdapter());
    personalBox = await Hive.openBox(HiveKey.personalCollection);
    scheduleBox = await Hive.openBox(HiveKey.schoolCollection);
    studentBox = await Hive.openBox(HiveKey.studentInfoCollection);
  }

  void dispose() {
    personalBox.compact();
    scheduleBox.compact();
    Hive.close();
  }
}