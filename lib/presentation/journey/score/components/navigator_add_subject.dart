import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/data/remote/score_respository.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_color.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_text.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

class NavigatorAddSubject extends StatelessWidget {
  final String name;
  final String id;
  final String numberOfCredits;
  const NavigatorAddSubject(
      {required this.id,
      required this.name,
      required this.numberOfCredits,
      super.key});

  @override
  Widget build(BuildContext context) {
    HiveScoresCell hiveScoresCell = HiveScoresCell();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40.sp, bottom: 40.sp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.blue800, size: 30)),
                  Text("Thêm môn học", style: ThemeText.bodySemibold.s18),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(right: 10.sp),
                      child: nameContainer(name, "Tên môn học"),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(left: 10.sp),
                          child: nameContainer(numberOfCredits, "Số tín chỉ"))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 10.sp),
                    child: textField(
                      onChanged: (p0) {
                        hiveScoresCell.firstComponentScore = p0;
                      },
                      hintText: "Điểm TP1",
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 10.sp),
                    child: textField(
                      onChanged: (p0) {
                        hiveScoresCell.secondComponentScore = p0;
                      },
                      hintText: "Điểm TP2",
                    ),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  Expanded(
                      child: textField(
                    onChanged: (p0) {
                      if (p0.trim().isEmpty) {
                        hiveScoresCell.examScore = 'null';
                      } else {
                        hiveScoresCell.examScore = p0;
                      }
                      // }
                    },
                    hintText: "Điểm thi",
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 160.sp,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  backgroundColor: AppColors.blue900,
                  fixedSize: Size(400.sp, 47.sp),
                ),
                onPressed: () {
                  int n = 0;
                  for (int i = 0;
                      i < getIt<HiveConfig>().hiveScoresCell.length;
                      i++) {
                    if (getIt<HiveConfig>()
                            .hiveScoresCell
                            .values
                            .elementAt(i)
                            .name ==
                        name) {
                      n++;
                    }
                  }
                  if (n == 0) {
                    try {
                      getIt<ScoreRepository>().insertScoreEng(
                          getIt<ScoreRepository>()
                              .calAvgScore(hiveScoresCell)!
                              .toString(),
                          name,
                          id,
                          int.parse(numberOfCredits),
                          getIt<ScoreRepository>()
                              .calAlphabetScore(hiveScoresCell)!,
                          hiveScoresCell.examScore!,
                          hiveScoresCell.firstComponentScore!,
                          hiveScoresCell.secondComponentScore!);
                      showTopSnackBar(context,
                          message: 'Thêm môn học thành công',
                          type: SnackBarType.done);
                      Get.back();
                      // }
                    } catch (e) {
                      showTopSnackBar(context,
                          message:
                              'Các trường phải được điền chính xác và không được bỏ trống',
                          type: SnackBarType.error);
                    }
                  }
                  if (n != 0) {
                    try {
                      showTopSnackBar(context,
                          message: 'Môn học đã tồn tại',
                          type: SnackBarType.error);
                    } catch (e) {
                      showTopSnackBar(context,
                          message:
                              'Các trường phải điền chính xác và không được bỏ trống',
                          type: SnackBarType.error);
                    }
                  }
                },
                child: Text(
                  'Lưu',
                  style: ThemeText.bodySemibold
                      .copyWith(color: AppColors.bianca, fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(
      {required String hintText, required Function(String) onChanged}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: ThemeText.bodySemibold.s15,
          ),
          SizedBox(
            height: 5.sp,
          ),
          Container(
            height: 45.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.blue800, width: 0.5),
            ),
            child: TextField(
              style: ThemeText.bodyMedium.s16,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameContainer(String name, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: ThemeText.bodySemibold.s16),
        SizedBox(
          height: 5.sp,
        ),
        Container(
          width: 400.sp,
          height: 45.sp,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue800, width: 0.5),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 12.sp),
            child: Text(name,
                textAlign: TextAlign.center, style: ThemeText.bodyMedium.s16),
          ),
        ),
      ],
    );
  }
}
