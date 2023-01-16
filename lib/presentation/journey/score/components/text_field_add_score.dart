import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class TextFieldAddScore extends StatelessWidget {
  const TextFieldAddScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 20.sp),
              hintText: ("Thêm điểm TP1"),
              hintStyle: TextStyle(color: AppColors.blue800)),
          style: ThemeText.bodySemibold
              .copyWith(color: AppColors.blue800, fontSize: 14.sp),
        ),
        // Divider(
        //   color: AppColors.blue800,
        // ),
      ],
    );
  }
}
