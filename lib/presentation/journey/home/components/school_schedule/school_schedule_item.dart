import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/constants/theme_border.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class SchoolScheduleElementWidget extends StatelessWidget {
  final StudentSchedule schedule;

  const SchoolScheduleElementWidget({Key? key, required this.schedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List lessonNumbers = schedule.lesson!.split(',');
    String startLesson = lessonNumbers[0];
    String endLesson = lessonNumbers[lessonNumbers.length - 1];

    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${Convert.startTimeLessonMap[startLesson]}',
                    style: ThemeText.bodyMedium.red,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.red,
                    size: 16.sp,
                  ),
                  Text(
                    '${Convert.endTimeLessonMap[endLesson]}',
                    style: ThemeText.bodyMedium.red,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              decoration: BoxDecoration(
                border: Border(
                  left: ThemeBorder.scheduleElementBorder
                      .copyWith(color: AppColors.red),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${schedule.subjectName}',
                    style: ThemeText.bodySemibold.red,
                  ),
                  Text(
                    (schedule.room ?? '').contains('null')
                        ? 'Không có dữ liệu'
                        : '${schedule.room}',
                    style: ThemeText.bodyRegular.red,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
