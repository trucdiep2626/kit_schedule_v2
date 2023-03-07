import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/constants/shared_preferences_constants.dart';

import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/mixin_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/services/local_notification_service.dart';

class SettingController extends GetxController with MixinController {
  RxBool isNotification = false.obs;
  RxInt timeNotification = 0.obs;
  SharePreferencesConstants sharePreferencesConstants;

  SettingController({required this.sharePreferencesConstants});
  @override
  void onInit() {
    super.onInit();

    notifications();
    isNotification.value = sharePreferencesConstants.getIsNotification();
    timeNotification.value = sharePreferencesConstants.getTimeNotification();
  }

  void onChangedNotification(bool value) {
    isNotification.value = value;
    sharePreferencesConstants.setNotification(isNotification: value);
  }

  void onChangedTimeNotification(int newValue) {
    timeNotification.value = newValue;
    sharePreferencesConstants.setTimeNotification(timeNotification: newValue);
  }

  ///lên 50 lịch học tính từ thời điểm hiện tại
  void _schoolScheduleNotifications() async {
    //lấy ra những lịch học trong ngày
    List<StudentSchedule>? schoolSchedules =
        (Get.find<HomeController>().studentSchedule).where((element) {
      List lessonNumbers = element.lesson!.split(',');
      String startLesson = lessonNumbers[0];

      DateTime date = Convert.dateTimeConvert(
              Convert.startTimeLessonMap[startLesson]!, element.day!)
          .add(Duration(minutes: -timeNotification));
      if (date.isAfter(DateTime.now())) {
        return true;
      }
      return false;
    }).toList();
//lên 50 lịch học
    for (var element in schoolSchedules) {
      if (schoolSchedules.indexOf(element) > 50) break;

      List lessonNumbers = element.lesson!.split(',');
      String startLesson = lessonNumbers[0];

      DateTime date = Convert.dateTimeConvert(
              Convert.startTimeLessonMap[startLesson]!, element.day!)
          .add(Duration(minutes: -timeNotification));

      String time =
          '${Convert.startTimeLessonMap[startLesson]!} |  ${element.room!}';

      LocalNotificationService.setupNotification(
          title: element.subjectName.toString(),
          content: time,
          scheduleDateTime: date,
          notiId: schoolSchedules.indexOf(element));
    }
  }

  ///lên 10 lịch cá nhân tính từ thời điểm hiện tại
  void _personalScheduleNotifications() async {
    ///lấy ra những lịch cá nhân trong ngày
    List<PersonalScheduleModel> personalSchedules =
        (Get.find<HomeController>().personalSchedule).where((element) {
      DateTime date = Convert.dateTimeConvert(element.timer!, element.date!)
          .add(Duration(minutes: -timeNotification));
      if (date.isAfter(DateTime.now())) {
        return true;
      }
      return false;
    }).toList();

    ///lên 10 lịch cá nhân
    for (var element in personalSchedules) {
      if (personalSchedules.indexOf(element) > 10) break;
      DateTime date = Convert.dateTimeConvert(element.timer!, element.date!)
          .add(Duration(minutes: -timeNotification));
      if (isNullEmpty(element.note)) {
        element.note = 'Bạn có lịch cá nhân!';
      }
      String content = '${element.timer}  -  ${element.note!}';
      LocalNotificationService.setupNotification(
          title: element.name.toString(),
          content: content,
          scheduleDateTime: date,
          notiId: personalSchedules.indexOf(element) + 100);
    }
  }

  ///lên lịch lại mỗi lần mở app, lịch mới sẽ được tính từ thời điểm hiện tại
  void notifications() async {
    await LocalNotificationService.cancelAllScheduleNotification();
    if (isNotification.value) {
      _schoolScheduleNotifications();
      _personalScheduleNotifications();
    }
  }
}
