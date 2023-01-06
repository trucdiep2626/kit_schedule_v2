// import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/extensions/string_extensions.dart';
// import 'package:intl/intl.dart';
// import 'package:kit_schedule_v2/common/utils/export.dart';
// import 'package:kit_schedule_v2/presentation/theme/export.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class CalendarPopupView extends StatefulWidget {
//   const CalendarPopupView({
//     super.key,
//     this.pickOutDate = false,
//     required this.code,
//     required this.firstDay,
//     this.selectedDay,
//   });
//   final bool pickOutDate;
//   final String code;
//   final DateTime firstDay;
//   final DateTime? selectedDay;
//
//   @override
//   State<CalendarPopupView> createState() => _CalendarPopupViewState();
// }
//
// class _CalendarPopupViewState extends State<CalendarPopupView>
//     with TickerProviderStateMixin {
//   DateTime now = DateTime.now();
//   late DateTime _selectedDay;
//   late DateTime _focusedDay;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = widget.selectedDay ?? now;
//     _focusedDay = widget.selectedDay ?? now;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.only(top: 24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.all(Radius.circular(24)),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 offset: const Offset(4, 4),
//                 blurRadius: 8,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Divider(height: 1),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TableCalendar<dynamic>(
//                   locale: widget.code,
//                   firstDay: widget.firstDay,
//                   lastDay: DateTime(
//                     DateTime.now().year + 5,
//                   ), // TODO(dieptt): chưa cập nhật spec
//                   currentDay: DateTime.now(),
//                   focusedDay: _focusedDay,
//                   headerStyle: HeaderStyle(
//                     leftChevronIcon:   Icon(
//                       Icons.chevron_left,
//                       color: AppColors.black54,
//                     ),
//                     rightChevronIcon:   Icon(
//                       Icons.chevron_right,
//                       color: AppColors.black54,
//                     ),
//                     formatButtonVisible: false,
//                     titleTextFormatter:
//                         (date, locale) =>
//                     (DateFormat.yMMMM(locale).format(date).capitalize ?? ''),
//                     titleCentered: true,
//                     titleTextStyle: ThemeText.bodySemibold
//                         .copyWith(color: AppColors.black54, fontSize: 18.sp),
//                   ),
//                   startingDayOfWeek: StartingDayOfWeek.monday,
//                   daysOfWeekStyle: DaysOfWeekStyle(
//                     dowTextFormatter: (date, locale) =>
//                         DateFormat.E(locale).format(date).formatDayOfWeek(),
//                   ),
//                   calendarStyle: CalendarStyle(
//                     outsideDaysVisible: false,
//                     todayTextStyle:
//                         const TextStyle(color: AppStyles.colorBlack),
//                     todayDecoration: BoxDecoration(
//                       color: AppStyles.transparent,
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppStyles.orange400),
//                     ),
//                     selectedDecoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppStyles.orange400,
//                     ),
//                   ),
//                   selectedDayPredicate: (day) {
//                     return isSameDay(_selectedDay, day);
//                   },
//                   onDaySelected: _onDaySelected,
//                 ),
//               ),
//               const Divider(height: 1),
//               SizedBox(
//                 width: double.maxFinite,
//                 height: 50,
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pop(
//                             context,
//                             const PopupArgs(
//                               isShowTimePicker: false,
//                             ),
//                           );
//                         },
//                         child: Text(
//                           L10n.of(context).msgap349,
//                           textAlign: TextAlign.center,
//                           style: AppStyles.heading4.grey900Color,
//                         ),
//                       ),
//                     ),
//                     VerticalDivider(
//                       color: Theme.of(context).dividerColor,
//                     ),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pop(
//                             context,
//                             PopupArgs(
//                               dateTime: _selectedDay,
//                               isShowTimePicker: false,
//                             ),
//                           );
//                         },
//                         child: Text(
//                           L10n.of(context).msgap211,
//                           textAlign: TextAlign.center,
//                           style: AppStyles.heading4.orange400Color,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     setState(() {
//       if (widget.pickOutDate) {
//         _focusedDay = focusedDay;
//         _selectedDay = _focusedDay;
//       } else {
//         if (selectedDay.isAfter(now) ||
//             (selectedDay.day == now.day &&
//                 selectedDay.month == now.month &&
//                 selectedDay.year == now.year)) {
//           _focusedDay = focusedDay;
//           _selectedDay = _focusedDay;
//         }
//       }
//     });
//   }
// }
//
// class PopupArgs {
//   const PopupArgs({this.dateTime, required this.isShowTimePicker});
//
//   final DateTime? dateTime;
//   final bool isShowTimePicker;
// }
