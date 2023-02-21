import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/setting/setting_controller.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

class TodoController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxTodoLoadedType = LoadedType.finish.obs;

  RxString selectedTime = ''.obs;
  RxString selectedDate = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  RxBool isKeyboard = false.obs;
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<PersonalScheduleModel?> personalSchedule =
      (null as PersonalScheduleModel?).obs;
  RxString validateText = ''.obs;
  String msv = '';

  // String _date = DateTime.utc(DateTime.now().year, DateTime.now().month,
  //     DateTime.now().day, 0, 0, 0, 0)
  //     .millisecondsSinceEpoch
  //     .toString();
  // String _timer = '${Convert.timerConvert(TimeOfDay.now())}';

  final PersonalUsecase personalUsecase;

  TodoController(this.personalUsecase);

  //verride
  // Future<void> onReady() async {
  //   super.onReady();
  //   // selectedDate.value =DateTime.utc(DateTime.now().year, DateTime.now().month,
  //   //     DateTime.now().day, 0, 0, 0, 0)
  //   //     .millisecondsSinceEpoch
  //   //     .toString() ;
  //   // selectedTime.value =
  //   // '${Convert.timerConvert(TimeOfDay.now())}';
  //   //
  //   // debugPrint('----------${selectedDate.value}----${selectedTime.value}');
  // }

  bool checkValidateInput() {
    if (nameController.text.trim().isEmpty) {
      validateText.value = 'Thông tin này không được phép bỏ trống';
      return false;
    }
    return true;
  }

  void onSelectDate(DateTime newSelectedDate) {
    rxTodoLoadedType.value = LoadedType.start;
    selectedDate.value = DateTimeFormatter.formatDate(newSelectedDate);
    rxTodoLoadedType.value = LoadedType.finish;
  }

  void onSelectTime(TimeOfDay newTime) {
    rxTodoLoadedType.value = LoadedType.start;
    selectedTime.value = Convert.timerConvert(newTime);
    rxTodoLoadedType.value = LoadedType.finish;
  }

  Future<void> createTodo() async {
    if (!checkValidateInput()) {
      return;
    }

    rxTodoLoadedType.value = LoadedType.start;
    final String now = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      await personalUsecase.insertPersonalScheduleLocal(PersonalScheduleModel(
        date: selectedDate.value,
        name: nameController.text.trim(),
        timer: selectedTime.value,
        note: noteController.text.trim(),
        updateAt: now,
        createAt: now,
      ));
      showTopSnackBar(context,
          message: 'Tạo ghi chú thành công', type: SnackBarType.done);

      await Get.find<HomeController>().getPersonalScheduleLocal();
      Get.find<SettingController>().notifications();
      resetData();
    } catch (e) {
      showTopSnackBar(context,
          message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
          type: SnackBarType.error);
    }
    rxTodoLoadedType.value = LoadedType.finish;
  }

  Future<void> updateTodo() async {
    if (!checkValidateInput()) {
      return;
    }

    rxTodoLoadedType.value = LoadedType.start;
    final String now = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      final result = await personalUsecase
          .updatePersonalScheduleDataLocal(PersonalScheduleModel(
        date: selectedDate.value,
        name: nameController.text.trim(),
        timer: selectedTime.value,
        note: noteController.text.trim(),
        updateAt: personalSchedule.value?.createAt ?? now,
        createAt: personalSchedule.value?.createAt ?? now,
      ));
      if (result) {
        showTopSnackBar(context,
            message: 'Cập nhật ghi chú thành công', type: SnackBarType.done);
        await Get.find<HomeController>().getPersonalScheduleLocal();
        Get.find<SettingController>().notifications();
        resetData();
        Get.back();
      } else {
        showTopSnackBar(context,
            message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
            type: SnackBarType.error);
      }
    } catch (e) {
      showTopSnackBar(context,
          message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
          type: SnackBarType.error);
    }
    rxTodoLoadedType.value = LoadedType.finish;
  }

  void resetData() {
    validateText.value = '';
    nameController.clear();
    noteController.clear();
    personalSchedule.value = null;
    selectedDate.value = DateTimeFormatter.formatDate(DateTime.now());
    selectedTime.value = '${Convert.timerConvert(TimeOfDay.now())}';
  }

  Future<void> deleteTodo() async {
    rxTodoLoadedType.value = LoadedType.start;

    try {
      final result = await personalUsecase
          .deletePersonalScheduleLocal(personalSchedule.value!);
      if (result) {
        showTopSnackBar(context,
            message: 'Xoá ghi chú thành công', type: SnackBarType.done);
        await Get.find<HomeController>().getPersonalScheduleLocal();
        Get.find<SettingController>().notifications();
        resetData();
        Get.back(result: true);
      } else {
        showTopSnackBar(context,
            message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
            type: SnackBarType.error);
      }
    } catch (e) {
      showTopSnackBar(context,
          message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
          type: SnackBarType.error);
    }
    rxTodoLoadedType.value = LoadedType.finish;
  }

  void getPersonalSchedule(PersonalScheduleModel personalScheduleModel) {
    personalSchedule.value = personalScheduleModel;
    nameController.text = personalSchedule.value?.name ?? '';
    noteController.text = personalSchedule.value?.note ?? '';
    selectedDate.value = personalSchedule.value?.date ??
        DateTimeFormatter.formatDate(DateTime.now());
    selectedTime.value = personalSchedule.value?.timer ??
        '${Convert.timerConvert(TimeOfDay.now())}';
  }

  @override
  void onInit() {
    //
    // final args = Get.arguments;
    // debugPrint('1=============$args');
    // if (args != null) {
    //
    // } else {
    selectedDate.value = DateTimeFormatter.formatDate(DateTime.now());
    selectedTime.value = '${Convert.timerConvert(TimeOfDay.now())}';
    // }

    KeyboardVisibilityController().onChange.listen((event) async {
      isKeyboard.value = event;
      if (isKeyboard.value == false) {
        await Future.delayed(const Duration(milliseconds: 110));
        //  if (mounted) setState(() {});
      } else {
        // if (mounted) setState(() {});
      }
    });

    debugPrint('----------${selectedDate.value}----${selectedTime.value}');
  }
}
