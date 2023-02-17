import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class ButtonAddScore extends StatelessWidget {
  final String subjectName;
  final Function() onPressed;
  const ButtonAddScore(
      {required this.subjectName, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Container(
            alignment: Alignment.center,
            height: 45.sp,
            child: Text(
              subjectName,
              style: ThemeText.bodySemibold.s18,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
