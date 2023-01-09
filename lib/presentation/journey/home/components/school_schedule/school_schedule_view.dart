import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/school_schedule/school_schedule_item.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class SchoolScheduleWidget extends GetView<HomeController> {
  const SchoolScheduleWidget({Key? key, required this.selectedDate})
      : super(key: key);

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<StudentSchedule>? schoolSchedulesOfDay =
            (controller.studentSchedule)
                .where((element) =>
                    element.day == DateTimeFormatter.formatDate(selectedDate))
                .toList();

        return Card(
          semanticContainer: true,
          color: AppColors.red100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8.sp),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Lịch học',
                    style: ThemeText.bodyStrong.red.s16,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.red,
                    ),
                    margin: EdgeInsets.only(left: 4.sp),
                    padding: EdgeInsets.all(5.sp),
                    child: Text(
                      '${schoolSchedulesOfDay.length}',
                      style: ThemeText.bodyMedium.bianca,
                    ),
                  )
                ],
              ),
              Expanded(
                child: schoolSchedulesOfDay.isNotEmpty
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
                          },
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Không có dữ liệu',
                          style: ThemeText.bodyMedium.red,
                        ),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
