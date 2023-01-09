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

class CalendarView extends StatefulWidget {
  CalendarView({
    Key? key,
    required this.schedules,
    required this.personals,
  }) : super(key: key);

  List<StudentSchedule> schedules;
  List<PersonalScheduleModel> personals;

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          color: AppColors.backgroundColor),
      child: TableCalendar(
        locale: 'vi', // TODO(dieptt): add locale
        currentDay: _selectedDay,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: ThemeText.bodySemibold.black54,
            weekendStyle: ThemeText.bodyRegular.red),
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          markerDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue600,
          ),
          todayDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue200,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.blue900,
          ),
          markerSize: 8.sp,
          rangeHighlightColor: AppColors.blue900,
          markersMaxCount: 1,
          outsideDaysVisible: true,
          weekendTextStyle: const TextStyle(color: AppColors.red),
          selectedTextStyle: const TextStyle(color: AppColors.red),
          todayTextStyle: const TextStyle(
              color: AppColors.bianca, fontWeight: FontWeight.bold),
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
        onDaySelected: (
          selectedDay,
          focusedDay,
        ) =>
            _onDaySelected(selectedDay, focusedDay, context),
      ),
    );
  }

  List _getEventsForDay(DateTime day) {
    List<dynamic> events = [];
    events.addAll(widget.schedules
        .where((element) => DateTimeFormatter.formatDate(day) == element.day)
        .toList());
    events.addAll(widget.personals
        .where((element) => DateTimeFormatter.formatDate(day) == element.date)
        .toList());
    return events;
  }

  void _onDaySelected(
      DateTime selectedDay, DateTime focusedDay, BuildContext context) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
    Get.find<HomeController>().onChangedSelectedDate(selectedDay);
  }
}
