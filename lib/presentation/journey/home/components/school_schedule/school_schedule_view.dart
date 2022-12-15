import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/school_schedule/school_schedule_item.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class SchoolScheduleWidget extends GetView<MainController> {
  SchoolScheduleWidget({Key? key, required this.selectedDate})
      : super(key: key);

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    List<StudentSchedule>? schoolSchedulesOfDay =
        (controller.schoolScheduleModel.value.studentSchedule ?? [])
            .where((element) =>
                element.day == DateTimeFormatter.formatDate(selectedDate))
            .toList();
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
      //   margin: EdgeInsets.symmetric(
      //     vertical: WidgetsConstants.cardMargin),
      color: AppColors.scheduleBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 8.sp),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Lịch học',
                  style: ThemeText.titleStyle.copyWith(
                    color: AppColors.scheduleType,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
                margin: EdgeInsets.only(left: 4.sp),
                padding: EdgeInsets.all(5.sp),
                child: Text(
                    schoolSchedulesOfDay != null
                        ? '${schoolSchedulesOfDay.length}'
                        : '0',
                    style: ThemeText.numberStyle),
              )
            ],
          ),
          Expanded(
            child: schoolSchedulesOfDay != null
                ? Padding(
                    padding: EdgeInsets.only(bottom: 8.sp),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: schoolSchedulesOfDay.length,
                        itemBuilder: (context, index) {
                          StudentSchedule schedule =
                              schoolSchedulesOfDay[index];
                          return SchoolScheduleElementWidget(
                              schedule: schedule);
                        }),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Text('Không có dữ liệu',
                        style: ThemeText.textStyle
                            .copyWith(color: AppColors.scheduleType)),
                  ),
          )
        ],
      ),
    );
  }
}
