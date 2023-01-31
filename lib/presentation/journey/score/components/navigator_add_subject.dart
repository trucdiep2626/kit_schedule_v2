// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/data/remote/score_repository.dart';
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
              margin: EdgeInsets.only(top: 40.h, bottom: 10.h),
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
              margin: EdgeInsets.only(
                  bottom: 20.sp, top: 20.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: nameContainer(name, "Tên môn học"),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(left: 10.w),
                          child: nameContainer(numberOfCredits, "Số tín chỉ"))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: 20.sp, top: 20.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: textField(
                        onChanged: (p0) {
                          // if (p0.trim().isEmpty) {
                          //   return "Vui lòng điền đủ trường!!!";
                          // } else {
                          //   hiveScoresCell.firstComponentScore = p0;
                          // }
                          hiveScoresCell.firstComponentScore = p0;
                        },
                        hintText: "Điểm thành phần 1",
                        textController: hiveScoresCell.firstComponentScore),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 10.w),
                    child: textField(
                        onChanged: (p0) {
                          // if (p0.trim().isEmpty) {
                          //   return "Vui lòng điền đủ trường!!!";
                          // } else {
                          //   hiveScoresCell.secondComponentScore = p0;
                          // }
                          hiveScoresCell.secondComponentScore = p0;
                        },
                        hintText: "Điểm thành phần 2",
                        textController: hiveScoresCell.secondComponentScore),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: 40.sp, top: 20.sp, left: 10.sp, right: 10.sp),
              child: Row(
                children: [
                  Expanded(
                      child: textField(
                          onChanged: (p0) {
                            // if (p0.trim().isEmpty) {
                            //   return "Vui lòng điền đủ trường!!!";
                            // } else {
                            hiveScoresCell.examScore = p0;
                            // }
                          },
                          hintText: "Điểm thi",
                          textController: hiveScoresCell.examScore)),
                ],
              ),
            ),
            SizedBox(
              height: 250.sp,
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
                  // if (hiveScoresCell.examScore!.trim().isEmpty ||
                  //     hiveScoresCell.firstComponentScore!.trim().isEmpty ||
                  //     hiveScoresCell.secondComponentScore!.trim().isEmpty) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: const Text('Vui lòng điền đủ trường!!!'),
                  //       elevation: 15.sp,
                  //       behavior: SnackBarBehavior.floating,
                  //       duration: const Duration(seconds: 1),
                  //     ),
                  //   );
                  // } else {
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
                    //  else {
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
                    // }
                  }
                  if (n != 0) {
                    showTopSnackBar(context,
                        message: 'Môn học đã tồn tại',
                        type: SnackBarType.error);
                  }
                  // log(getIt<ScoreRepository>().calSumScoresCell().toString());
                  // log(getIt<ScoreRepository>().calTotalCredits().toString());
                  // log((getIt<ScoreRepository>().calSumScoresCell() /
                  //         getIt<ScoreRepository>().calTotalCredits())
                  //     .toStringAsFixed(2));

                  // getIt<HiveConfig>().hiveScoresCell.add(HiveScoresCell(
                  //       alphabetScore:
                  //           hiveScoresCell.calAlphabetScore(hiveScoresCell),
                  //       examScore: hiveScoresCell.examScore,
                  //       firstComponentScore: hiveScoresCell.firstComponentScore,
                  //       secondComponentScore: hiveScoresCell.secondComponentScore,
                  //       avgScore: hiveScoresCell
                  //           .calAvgScore(hiveScoresCell)!
                  //           .toStringAsFixed(1),
                  //       id: id,
                  //       name: name,
                  //       numberOfCredits: 3,
                  //     ));
                  Get.back();
                  // }
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

  // void checkValidateInput(HiveScoresCell hiveScoresCell)
  // {
  //   if(hiveScoresCell.examScore!.trim().isEmpty)
  //     {
  //       validateText.value = 'Thông tin này không được phép bỏ trống';
  //     }
  // }
  Widget textField(
      {required String hintText,
      required String? textController,
      required Function(String) onChanged}) {
    // controller.text != null
    //     ? textController = controller.text
    //     : textController = "";
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: ThemeText.bodySemibold.s16,
          ),
          Container(
            height: 45.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.blue800),
            ),
            child: TextField(
              style: ThemeText.bodyMedium.s16,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              decoration: const InputDecoration(
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blue800, width: 1)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blue800, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blue800, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.errorColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blue800, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
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
        Text(title, style: ThemeText.bodySemibold.s18),
        Container(
          width: 400.sp,
          height: 45.sp,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.blue800, width: 1),
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
