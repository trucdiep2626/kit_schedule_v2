import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';

class TodoController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxTodoLoadedType = LoadedType.finish.obs;

  RxString selectedTime = ''.obs;
  RxString selectedDate = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  RxBool isKeyboard = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Future<void> onReady() async {
    super.onReady();
    selectedDate.value = DateTimeFormatter.formatDate(DateTime.now());
    selectedTime.value =
        Convert.timerConvert(TimeOfDay.fromDateTime(DateTime.now()));
  }

  @override
  void onInit() {
    KeyboardVisibilityController().onChange.listen((event) async {
      isKeyboard.value = event;
      if (isKeyboard == false) {
        await Future.delayed(const Duration(milliseconds: 110));
        //  if (mounted) setState(() {});
      } else {
        // if (mounted) setState(() {});
      }
    });
  }
}
