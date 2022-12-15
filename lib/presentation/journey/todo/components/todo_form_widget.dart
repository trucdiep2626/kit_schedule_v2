import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/components/cupertino_rounded_datepicker_widget.dart';
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
          Form(
            key: controller.formKey,
            child: TextFieldWidget(
              controller: controller.nameController,
              labelText: 'Tiêu đề',
              textStyle:
                  ThemeText.labelStyle.copyWith(fontWeight: FontWeight.w400),
              colorBoder: AppColors.personalScheduleColor,
              validate: (value) {
                if (value!.trim().isEmpty) {
                  return "Không được phép bỏ trống ô này";
                }
                return null;
              },
            ),
          ),
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
                          context,
                          DateTimeFormatter.stringToDate(selectedDate
                              )),
                      isDate: true,
                    )),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                    child: SetTimeWidget(
                      onTap: () => _selectTimePicker(
                          context, selectedTime.split(':')),
                      title: 'Thời gian',
                    )),
              ],
            );
          }

    ),
          SizedBox(
            height: 18.sp,
          ),
          TextFieldWidget(
            controller: controller.noteController,
            labelText: 'Ghi chú',
            textStyle:
                ThemeText.labelStyle.copyWith(fontWeight: FontWeight.w400),
            colorBoder: AppColors.personalScheduleColor,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  _selectDatePicker(BuildContext context, DateTime initialDate) async {
    CupertinoRoundedDatePickerWidget.show(
      context,
      initialDate: initialDate,
      textColor: AppColors.personalScheduleColor,
      initialDatePickerMode: CupertinoDatePickerMode.date,
      fontFamily: 'MR',
      onDateTimeChanged: (dataTime) {
        // BlocProvider.of<TodoBloc>(context)
        //   ..add(SelectDatePickerOnPressEvent(selectDay: dataTime));
      },
      borderRadius: 20,
      maximumYear: DateTime.now().year + 10,
      minimumYear: DateTime.now().year - 10,
    );
  }

  _selectTimePicker(BuildContext context, List<String> hourAndMinues) async {
    debugPrint('========${hourAndMinues.toString()}');
    int time = (int.parse(hourAndMinues[0]) * 60 * 60 * 1000) +
        (int.parse(hourAndMinues[1]) * 60 * 1000);
    DateTime a = DateTime.fromMillisecondsSinceEpoch(
        DateTime(2021).millisecondsSinceEpoch + time);
    CupertinoRoundedDatePickerWidget.show(
      context,
      initialDate: a,
      textColor: AppColors.personalScheduleColor,
      initialDatePickerMode: CupertinoDatePickerMode.time,
      fontFamily: 'MR',
      onDateTimeChanged: (dataTime) {
        // BlocProvider.of<TodoBloc>(context)
        //   ..add(SelectTimePickerOnPressEvent(
        //   timer: TimeOfDay.fromDateTime(dataTime)));
      },
      borderRadius: 20,
    );
  }
}
