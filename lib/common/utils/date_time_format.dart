import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatMinuteSecond(DateTime date) {
    final format = DateFormat('hh:mm');
    return format.format(date);
  }

  static DateTime stringToDate(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  static String formatDate(DateTime date) {
    final format = DateFormat('dd/MM/yyyy');
    return format.format(date);
  }

  // static String formatDOB(DateTime date) {
  //   final format = DateFormat('dd MMMM, yyyy');
  //   return format.format(date).formatDOB();
  // }

  static String formatDateYearFirst(DateTime date) {
    final format = DateFormat('yyyy/MM/dd');
    return format.format(date);
  }

  static String formatDate2(DateTime date) {
    final format = DateFormat('dd-MM-yyyy');
    return format.format(date);
  }

  static String formatDateYear(DateTime date) {
    final format = DateFormat('yyyy-MM-dd');
    return format.format(date);
  }

  static String formatDateAsAPIData(DateTime date) {
    final format = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return format.format(date);
  }

  static String formatDateByString(String date) {
    final format = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final result = DateFormat('dd/MM/yyyy').format(
      format.parse(date),
    );
    return result;
  }

  static String formatDMY(String? date) {
    final format = DateFormat('dd-MM-yyyy');
    String result;
    try {
      result = DateFormat('dd/MM/yyyy').format(
        format.parse(date!),
      );
    } catch (_) {
      result = '';
    }
    return result;
  }

  static String formatStringDateYearFirst(String date) {
    final format = DateFormat('yyyy/MM/dd');
    return format.format(DateFormat('dd/MM/yyyy').parse(date));
  }

  static String formatTimeNotification(DateTime date) {
    final format = DateFormat('hh:mm a', 'en');
    return format.format(date);
  }

  // static String formatDateNotification(BuildContext context, DateTime date) {
  //   final format = DateFormat('dd/mm/yyyy');
  //
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);
  //   final yesterday = DateTime(now.year, now.month, now.day - 1);
  //
  //   final aDate = DateTime(date.year, date.month, date.day);
  //   if (aDate == today) {
  //     return L10n.of(context).msgap461;
  //   } else if (aDate == yesterday) {
  //     return L10n.of(context).msgap462;
  //   }
  //
  //   return format.format(date);
  // }

  // static String formatDateTimeNotification(
  //   BuildContext context,
  //   DateTime inputDate,
  // ) {
  //   final time = formatTimeNotification(inputDate);
  //   final date = formatDateNotification(context, inputDate);
  //
  //   return '$time $date';
  // }
}
