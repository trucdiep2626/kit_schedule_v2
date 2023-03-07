import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';

import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarView extends GetView<HomeController> {
  const CalendarView({
    Key? key,
    required this.schedules,
    required this.personals,
  }) : super(key: key);

  final List<StudentSchedule> schedules;
  final List<PersonalScheduleModel> personals;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          color: AppColors.backgroundColor),
      child: Obx(
        () => TableCalendar(
          locale: 'vi',
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: controller.focusedDate.value,
          calendarFormat: CalendarFormat.month,
          rangeSelectionMode: RangeSelectionMode.toggledOff,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) =>
              isSameDay(controller.selectedDate.value, day),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: ThemeText.bodySemibold.black54,
            weekendStyle: ThemeText.bodyRegular.red,
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            markerDecoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue600,
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey300,
              border: Border.all(
                color: AppColors.blue500,
                width: 1.sp,
              ),
            ),
            selectedDecoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blue200,
            ),
            markerSize: 8.sp,
            rangeHighlightColor: AppColors.blue900,
            markersMaxCount: 1,
            outsideDaysVisible: true,
            weekendTextStyle: const TextStyle(
              color: AppColors.red,
            ),
            selectedTextStyle: const TextStyle(
              color: AppColors.bianca,
            ),
            todayTextStyle: const TextStyle(
              color: AppColors.black,
            ),
          ),
          headerStyle: HeaderStyle(
            titleTextStyle: ThemeText.bodySemibold.black54.s18,
            formatButtonVisible: false,
            titleCentered: true,
            titleTextFormatter: (date, locale) =>
                (DateFormat.yMMMM(locale).format(date).capitalize ?? ''),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              size: 18.sp,
              color: AppColors.black54,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
              color: AppColors.black54,
            ),
          ),
          onDaySelected: controller.onDaySelected,
          onPageChanged: (focusedDay) {
            controller.focusedDate.value = focusedDay;
          },
        ),
      ),
    );
  }

  List _getEventsForDay(DateTime day) {
    List<dynamic> events = [];
    events.addAll(schedules
        .where((element) => DateTimeFormatter.formatDate(day) == element.day)
        .toList());
    events.addAll(personals
        .where((element) => DateTimeFormatter.formatDate(day) == element.date)
        .toList());
    return events;
  }
}
