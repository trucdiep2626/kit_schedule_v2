import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/components/custom_date_picker.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/components/set_time_widget.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/text_field_widget.dart';

class TodoFormWidget extends GetView<TodoController> {
  // final GlobalKey<FormState> formKey;
  // final TextEditingController nameController;
  // final TextEditingController noteController;
  // final TodoState state;
  // final Function() setDatePicker;
  // final Function() setTimePicker;

  const TodoFormWidget({
    Key? key,
    // required this.formKey,
    // required this.nameController,
    // required this.noteController,
    // //  required this.state,
    // required this.setDatePicker,
    // required this.setTimePicker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      child: Column(
        children: [
          Obx(() => TextFieldWidget(
                controller: controller.nameController,
                labelText: 'Tiêu đề',
                textStyle: ThemeText.bodyRegular,
                colorBoder: AppColors.blue800,
                errorText: controller.validateText.value,
              )),
          SizedBox(
            height: 18.sp,
          ),
          Obx(() {
            var selectedTime = controller.selectedTime.value;
            var selectedDate = controller.selectedDate.value;
            return Row(
              children: [
                Expanded(
                    child: SetTimeWidget(
                  title: 'Ngày',
                  onTap: () => _selectDatePicker(
                      context, DateTimeFormatter.stringToDate(selectedDate)),
                  isDate: true,
                )),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                    child: SetTimeWidget(
                  onTap: () =>
                      _selectTimePicker(context, selectedTime.split(':')),
                  title: 'Thời gian',
                )),
              ],
            );
          }),
          SizedBox(
            height: 18.sp,
          ),
          TextFieldWidget(
            controller: controller.noteController,
            labelText: 'Ghi chú',
            textStyle: ThemeText.bodyRegular,
            colorBoder: AppColors.blue800,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  _selectDatePicker(BuildContext context, DateTime initialDate) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Material(
        child: SizedBox(
          height: 350.sp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16.sp, 16.sp, 0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: ThemeText.bodyRegular,
                  ),
                ),
              ),

              SizedBox(
                //   color: AppColors.primary,
                height: 300,
                child: CustomCupertinoDatePicker(
                  //   borderRadius: 20,
                  maximumYear: DateTime.now().year + 10,
                  minimumYear: DateTime.now().year - 10,

                  mode: CupertinoDatePickerMode.date,

                  initialDateTime: initialDate,
                  onDateTimeChanged: (dateTime) =>
                      controller.onSelectDate(dateTime),
                ),
              ),

              // Close the modal
            ],
          ),
        ),
      ),
    );
    // CupertinoRoundedDatePickerWidget.show(
    //   context,
    //   initialDate: initialDate,
    //   textColor: AppColors.blue800,
    //   initialDatePickerMode: CupertinoDatePickerMode.date,
    //   fontFamily: 'MR',
    //   onDateTimeChanged: (dataTime) => controller.onSelectDate(dataTime)
    //   //{
    //   // BlocProvider.of<TodoBloc>(context)
    //   //   ..add(SelectDatePickerOnPressEvent(selectDay: dataTime));
    //   //}
    //   ,
    //   borderRadius: 20,
    //   maximumYear: DateTime.now().year + 10,
    //   minimumYear: DateTime.now().year - 10,
    // );
  }

  _selectTimePicker(BuildContext context, List<String> hourAndMinues) async {
    debugPrint('========${hourAndMinues.toString()}');
    int time = (int.parse(hourAndMinues[0]) * 60 * 60 * 1000) +
        (int.parse(hourAndMinues[1]) * 60 * 1000);
    DateTime a = DateTime.fromMillisecondsSinceEpoch(
        DateTime(2021).millisecondsSinceEpoch + time);
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Material(
        child: SizedBox(
          height: 350.sp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16.sp, 16.sp, 0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    'OK',
                    style: ThemeText.bodyRegular
                    //    .copyWith(color: AppColors.blue900)
                    ,
                  ),
                ),
              ),

              SizedBox(
                //   color: AppColors.primary,
                height: 300,
                child: CustomCupertinoDatePicker(
                  //   borderRadius: 20,
                  maximumYear: DateTime.now().year + 10,
                  minimumYear: DateTime.now().year - 10,

                  /// initialDate: initialDate,
                  // textColor: AppColors.blue800,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  //  fontFamily: 'MR',
                  initialDateTime: a,
                  onDateTimeChanged: (dateTime) =>
                      controller.onSelectTime(TimeOfDay.fromDateTime(dateTime)),
                ),
              ),
              // Close the modal
            ],
          ),
        ),
      ),
    );
    // CupertinoRoundedDatePickerWidget.show(
    //   context,
    //   initialDate: a,
    //   textColor: AppColors.blue800,
    //   initialDatePickerMode: CupertinoDatePickerMode.time,
    //   fontFamily: 'MR',
    //   onDateTimeChanged: (dataTime) =>
    //       controller.onSelectTime(TimeOfDay.fromDateTime(dataTime))
    //   //{
    //   // BlocProvider.of<TodoBloc>(context)
    //   //   ..add(SelectTimePickerOnPressEvent(
    //   //   timer: TimeOfDay.fromDateTime(dataTime)));
    //   //}
    //   ,
    //   borderRadius: 20,
    // );
  }
}
