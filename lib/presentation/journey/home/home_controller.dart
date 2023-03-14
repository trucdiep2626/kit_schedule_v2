import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeController extends GetxController with MixinController {
  final SchoolUseCase schoolUseCase;
  final PersonalUsecase personalUseCase;
  HomeController({
    required this.schoolUseCase,
    required this.personalUseCase,
  });

  final MainController mainController = Get.find<MainController>();
  Rx<bool> isLogin = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> focusedDate = DateTime.now().obs;
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
  }

  void onChangedSelectedDate(DateTime newDate) {
    focusedDate.value = newDate;
  }

  void onViewDetailTodo(PersonalScheduleModel toDoItem) {
    Get.back();
    Get.find<TodoController>().getPersonalSchedule(toDoItem);
    Get.toNamed(AppRoutes.todo);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDate.value, selectedDay)) {
      selectedDate.value = selectedDay;
      focusedDate.value = focusedDay;
    }
  }
}
