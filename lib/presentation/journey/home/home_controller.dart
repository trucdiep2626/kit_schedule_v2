import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/domain/models/personal_schedule_model.dart';
import 'package:schedule/domain/models/student_schedule_model.dart';
import 'package:schedule/domain/usecases/personal_usecase.dart';
import 'package:schedule/domain/usecases/school_usecase.dart';
import 'package:schedule/presentation/controllers/mixin/export.dart';
import 'package:schedule/presentation/journey/login/login_controller.dart';
import 'package:schedule/presentation/journey/login/login_success_dialog.dart';
import 'package:schedule/presentation/journey/main/main_controller.dart';
import 'package:schedule/presentation/journey/todo/todo_controller.dart';
import 'package:schedule/presentation/widgets/upgrade_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:upgrader/upgrader.dart';

class HomeController extends GetxController with MixinController {
  final SchoolUseCase schoolUseCase;
  final PersonalUsecase personalUseCase;
  final SharePreferencesConstants sharePrefes;
  HomeController(
      {required this.schoolUseCase,
      required this.personalUseCase,
      required this.sharePrefes});

  final MainController mainController = Get.find<MainController>();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> focusedDate = DateTime.now().obs;
  RxInt currentViewIndex = 0.obs;
  Rx<LoadedType> rxHomeLoadedType = LoadedType.start.obs;
  RxList<StudentSchedule> studentSchedule = <StudentSchedule>[].obs;
  RxList<PersonalScheduleModel> personalSchedule =
      <PersonalScheduleModel>[].obs;
  bool _showDialog = false;
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

  Future<void> _loadDialog() async {
    _showDialog = sharePrefes.getShowDialog();
    if (_showDialog) {
      loginSuccessDialog(
        Get.context!,
        btnOk: () {
          Get.back();
          showUpgradeDialog();
        },
      );
    } else {
      showUpgradeDialog();
    }
    sharePrefes.setShowDialog(showDialog: false);
  }

  void showUpgradeDialog() async {
    final upgrader = Upgrader();
    await upgrader.initialize();
    if (upgrader.isUpdateAvailable()) {
      upgradeDialog(
        context: context,
        btnUpgrade: _launchURLChPlay,
        store: defaultTargetPlatform == TargetPlatform.android
            ? "Google Play"
            : "App Store",
      );
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _loadDialog();
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

  _launchURLChPlay() async {
    StoreRedirect.redirect(
      androidAppId: "kma.hatuan314.schedule",
    );
  }
}
