import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

class TodoController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxTodoLoadedType = LoadedType.finish.obs;

  RxString selectedTime = ''.obs;
  RxString selectedDate = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  RxBool isKeyboard = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String msv = '';

  // String _date = DateTime.utc(DateTime.now().year, DateTime.now().month,
  //     DateTime.now().day, 0, 0, 0, 0)
  //     .millisecondsSinceEpoch
  //     .toString();
  // String _timer = '${Convert.timerConvert(TimeOfDay.now())}';

  final PersonalUsecase personalUsecase;

  TodoController(this.personalUsecase);

  // override
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
    rxTodoLoadedType.value = LoadedType.start;
    final String now = DateTime.now().millisecondsSinceEpoch.toString();
    //  bool hasNoti = await shareService.getHasNoti() ?? false;
    String id = '';
    // String date = DateTime.parse(
    //     DateTime.fromMillisecondsSinceEpoch(int.parse(this._date))
    //         .toString()
    //         .substring(0, 10))
    //     .millisecondsSinceEpoch
    //     .toString();
    // if (hasNoti) {
    //   //1630772220386
    //   debugPrint(
    //       DateTime.fromMillisecondsSinceEpoch(int.parse(date)).toString());
    //   await _retrieveCalendars();
    //id =
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
          message: 'Tạo nhắc nhở thành công', type: SnackBarType.done);
      nameController.clear();
      noteController.clear();
    } catch (e) {
      showTopSnackBar(context,
          message: 'Đã có lỗi xảy ra. Vui lòng thử lại',
          type: SnackBarType.error);
    }
    rxTodoLoadedType.value = LoadedType.finish;
    //   }
    //   PersonalScheduleEntities schedule(bool isSynch) {
    //     PersonalScheduleEntities schedule = PersonalScheduleEntities(
    //       id: id,
    //       date: date,
    //       name: event.name,
    //       timer: this._timer,
    //       note: event.note,
    //       isSynchronized: isSynch,
    //       updateAt: now,
    //       createAt: now,
    //     );
    //     debugPrint('todo id: ' + (schedule.id ?? ''));
    //     return schedule;
    //   }
    //
    //   try {
    //     // bool hasNoti= await shareService.getHasNoti() ?? false;
    //     // if(hasNoti)
    //     //   {
    //     //     await _retrieveCalendars();
    //     //     await _addPersonalScheduleToCalendar(schedule(true));
    //     //   }
    //     String result =
    //         await personalUS.syncPersonalSchoolDataFirebase(msv, schedule(true));
    //     if (result.isNotEmpty) {
    //       log('Not Empty');
    //       await personalUS.insertPersonalSchedule(schedule(true));
    //     } else {
    //       log('empty');
    //       await personalUS.insertPersonalSchedule(schedule(false));
    //     }
    //     _date = DateTime.now().millisecondsSinceEpoch.toString();
    //     _timer = '${Convert.timerConvert(TimeOfDay.now())}';
    //     calendarBloc!.add(GetAllScheduleDataEvent());
    //     snackbarBloc.add(ShowSnackbar(
    //         title: '${SnackBarTitle.CreateSuccess}', type: SnackBarType.success));
    //     yield TodoSuccessState(true, selectTimer: _timer, selectDay: _date);
    //     // String msv=await ShareService().getUsername() as String;
    //   } catch (e) {
    //     snackbarBloc.add(ShowSnackbar(
    //         title: '${SnackBarTitle.ConnectionFailed}',
    //         type: SnackBarType.error));
    //     yield TodoFailureState(
    //         error: e.toString(), selectDay: this._date, selectTimer: this._timer);
    // }
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
    selectedDate.value = DateTimeFormatter.formatDate(DateTime.now());
    selectedTime.value = '${Convert.timerConvert(TimeOfDay.now())}';

    debugPrint('----------${selectedDate.value}----${selectedTime.value}');
  }
}
