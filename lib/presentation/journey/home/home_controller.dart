import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/widget_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';

class HomeController extends GetxController with MixinController {
  final SchoolUseCase schoolUseCase;
  final PersonalUsecase personalUseCase;

  HomeController({
    required this.schoolUseCase,
    required this.personalUseCase,
  });

  final MainController mainController = Get.find<MainController>();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt currentViewIndex = 0.obs;
  Rx<LoadedType> rxHomeLoadedType = LoadedType.start.obs;
  RxList<StudentSchedule> studentSchedule = <StudentSchedule>[].obs;
  RxList<PersonalScheduleModel> personalSchedule =
      <PersonalScheduleModel>[].obs;

  Future<void> getScheduleLocal() async {
    await getSchoolScheduleLocal();
    await getPersonalScheduleLocal();
  }

  Future<void> getSchoolScheduleLocal() async {
    rxHomeLoadedType.value = LoadedType.start;
    studentSchedule.clear();
    studentSchedule.addAll(await schoolUseCase.getSchoolScheduleLocal());
    rxHomeLoadedType.value = LoadedType.finish;
  }

  Future<void> getPersonalScheduleLocal() async {
    rxHomeLoadedType.value = LoadedType.start;
    personalSchedule.clear();
    personalSchedule
        .addAll(await personalUseCase.fetchAllPersonalScheduleRepoLocal());
    rxHomeLoadedType.value = LoadedType.finish;
  }

  void onChangedView(int newIndex) {
    currentViewIndex.value = newIndex;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getScheduleLocal();
    _saveScheduleWidgetData();

  }

  void _saveScheduleWidgetData() async {
    try {
      final schedules = <ScheduleWidgetModel>[];
      for (StudentSchedule e in studentSchedule) {
        final lessons = e.lesson?.split(",");
        final scheduleWidgetModel = ScheduleWidgetModel(
          day: Convert.convertScheduleTime(
            e.day,
          ),
          startTime: Convert.convertScheduleTime(
            e.day,
            Convert.startTimeLessonMap[lessons?.first ?? "0"],
          ),
          endTime: Convert.convertScheduleTime(
            e.day,
            Convert.endTimeLessonMap[lessons?.last ?? "0"],
          ),
          subjectName: e.subjectName,
          room: e.room,
        );
        schedules.add(scheduleWidgetModel);
      }

    } on Exception catch (_) {
      rethrow;
    }
  }

  void onChangedSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void onViewDetailTodo(PersonalScheduleModel toDoItem) {
    Get.back();
    Get.find<TodoController>().getPersonalSchedule(toDoItem);
    Get.toNamed(AppRoutes.todo);
  }
}
