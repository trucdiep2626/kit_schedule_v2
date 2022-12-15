import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/constants/theme_border.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/school_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class SchoolScheduleElementWidget extends StatelessWidget {
  final StudentSchedule schedule;

  SchoolScheduleElementWidget({Key? key, required this.schedule})
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
                  Text('${Convert.startTimeLessonMap[startLesson]}',
                      style: ThemeText.textStyle
                          .copyWith(color: AppColors.scheduleType)),
                  Icon(Icons.arrow_drop_down,
                      color: AppColors.scheduleType,
                      size: ScreenUtil().setHeight(15)),
                  Text('${Convert.endTimeLessonMap[endLesson]}',
                      style: ThemeText.textStyle
                          .copyWith(color: AppColors.scheduleType)),
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
                          .copyWith(color: AppColors.scheduleType))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${schedule.subjectName}',
                      style: ThemeText.textStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.scheduleType)),
                  Text(
                      (schedule.room ?? '').contains('null')
                          ? 'Không có dữ liệu'
                          : '${schedule.room}',
                      style: ThemeText.textStyle
                          .copyWith(color: AppColors.scheduleType)
                          .copyWith(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
