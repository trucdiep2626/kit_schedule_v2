import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class SetTimeWidget extends GetView<TodoController> {
  final String title;
  final bool isDate;
  final Function() onTap;
  const SetTimeWidget(
      {Key? key, required this.title, this.isDate = false, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ThemeText.bodySemibold.copyWith(fontSize: 16.sp)),
          const SizedBox(height: 10),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      color: AppColors.blue800, width: 0.5)),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Text(
                isDate
                    ? controller.selectedDate.value
                    : controller.selectedTime.value,
                style: ThemeText.bodyRegular.s16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
