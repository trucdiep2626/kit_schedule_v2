import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

class DonateController extends GetxController {
  String accountNumber = '9500101009004';

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: accountNumber));
    showTopSnackBar(
      context,
      message: 'Đã sao chép vào bộ nhớ tạm',
      type: SnackBarType.done,
    );
  }
}
