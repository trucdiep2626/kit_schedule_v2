import 'package:flutter/material.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/presentation/theme/export.dart';

Future<void> displayAvgScoreDialog(BuildContext context,
    {required double avgSemester, required double scholarshipScore}) async {
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
            'Điểm Tổng Kết',
            style: ThemeText.bodySemibold
                .copyWith(color: AppColors.bianca, fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(avgSemester.toStringAsFixed(2),
                  style: ThemeText.bodyMedium.s48.blue900),
              avgSemester >= 3.0
                  ? Container(
                      margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
                      child: Text(
                        "Xin chúc mừng bạn đã có cơ hội được xét học bổng",
                        style: ThemeText.bodyMedium.s16.blue900,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Text(
                      "Rất tiếc. Bạn còn thiếu ${scholarshipScore.toStringAsFixed(2)} để được xét học bổng",
                      style: ThemeText.bodyMedium.s16.blue900,
                      textAlign: TextAlign.center,
                    )
            ],
          ),
        ),
      );
    },
  );
}
