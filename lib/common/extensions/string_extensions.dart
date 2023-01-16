extension StringExtensions on String {
  bool get isNullEmpty => this == null || "" == this || this == "null";
  String get cleanCurrencyFormatter {
    if (isNullEmpty) {
      return '';
    }
    return replaceAll('.', '').replaceAll(' ₫', '');
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String formatDOB() {
    return '${substring(0, 3)}${this[3].toUpperCase()}${substring(4).toLowerCase()}';
  }

  String formatDayOfWeek() {
    return '${this[0].toUpperCase()}${this[length - 1]}';
  }

}