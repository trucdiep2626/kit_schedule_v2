import 'package:flutter/material.dart';

import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

import 'package:table_calendar/table_calendar.dart';


class CalendarView extends StatefulWidget {


  const CalendarView({Key? key, }) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          color: Color(0xffFCFAF3)),
      child: TableCalendar(
        locale: 'vi', // TODO(dieptt): add locale
        currentDay: _selectedDay,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: ThemeText.dayOfWeekStyle,
            weekendStyle: ThemeText.dayOfWeekStyle
                .copyWith(color: AppColors.weekendTextColor)),
        calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            markerDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.markerColor),
            todayDecoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.todayColor),
            selectedDecoration:
            BoxDecoration(color: AppColors.selectedDayColor),
            markerSize: 8.sp,
            rangeHighlightColor: AppColors.selectedDayColor as Color,
            markersMaxCount: 1,
            outsideDaysVisible: true,
            weekendTextStyle:
            TextStyle(color: AppColors.weekendTextColor),
            selectedTextStyle:
            TextStyle(color: AppColors.dayTextColor),
            todayTextStyle:
            TextStyle(color: AppColors.dayTextColor)),
        headerStyle: HeaderStyle(
          titleTextStyle:
          ThemeText.titleStyle.copyWith(color: AppColors.thirdColor),
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            size: 18.sp,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            size: 18.sp,
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
    return
    //   this.widget.state!.allSchedulesCalendarMap[
    // DateTime.fromMillisecondsSinceEpoch(day.millisecondsSinceEpoch)] ??
        [];
  }

  void _onDaySelected(
      DateTime selectedDay, DateTime focusedDay, BuildContext context) {
    if (!isSameDay(_selectedDay, selectedDay))
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

    // BlocProvider.of<ScheduleBloc>(context)
    //   ..add(GetScheduleDayEvent(
    //       selectDay: selectedDay,
    //       allSchedulesSchoolMap: this.widget.state!.allSchedulesSchoolMap,
    //       allSchedulePersonalMap: this.widget.state!.allSchedulePersonalMap));
  }
}
