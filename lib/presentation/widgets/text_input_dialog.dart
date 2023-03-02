import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/button_add_scores.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

Future<void> displayTextInputDialog(
  BuildContext context, {
  required Function() onPressedEng1,
  required Function() onPressedEng2,
  required Function() onPressedEng3,
  required bool compareIdEnd1,
  required bool compareIdEnd2,
  required bool compareIdEnd3,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.all(16.sp),
          color: AppColors.blue900,
          child: Text(
            'Thêm môn học',
            style: ThemeText.bodySemibold
                .copyWith(color: AppColors.bianca, fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (compareIdEnd1) ...[
              ButtonAddScore(
                subjectName: "Tiếng Anh 1",
                onPressed: onPressedEng1,
              ),
              const Divider(
                color: AppColors.blue800,
                height: 1,
                thickness: 1,
              ),
            ],
            if (compareIdEnd2) ...[
              ButtonAddScore(
                subjectName: "Tiếng Anh 2",
                onPressed: onPressedEng2,
              ),
              const Divider(
                color: AppColors.blue800,
                height: 1,
                thickness: 1,
              ),
            ],
            if (compareIdEnd3) ...[
              ButtonAddScore(
                subjectName: "Tiếng Anh 3",
                onPressed: onPressedEng3,
              ),
              const Divider(
                color: AppColors.blue800,
                height: 1,
                thickness: 1,
              ),
            ]
          ],
        ),
      );
    },
  );
}
