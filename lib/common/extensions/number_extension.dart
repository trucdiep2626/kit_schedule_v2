extension NumberExtension on double {
  String get gpaTextScore {
    if (this < 2.0) return "Yếu";
    if (this < 2.5) return "Trung bình";
    if (this < 3.2) return "Khá";
    if (this < 3.6) return "Giỏi";
    return "Xuất sắc";
  }
}
