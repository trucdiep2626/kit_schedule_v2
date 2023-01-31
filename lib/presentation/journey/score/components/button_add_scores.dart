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
            // margin: EdgeInsets.only(top: 10.h),
            height: 45.h,
            // width: double.infinity,
            // decoration: const BoxDecoration(
            //     color: Colors.transparent,
            //     border: Border(bottom: BorderSide(color: AppColors.blue800))),
            child: Text(
              subjectName,
              style: ThemeText.bodySemibold.s18,
              textAlign: TextAlign.center,
            ),
          ),
          // Divider(
          //   color: AppColors.blue800,
          // ),
        ),
        const Divider(
          color: AppColors.blue800,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
