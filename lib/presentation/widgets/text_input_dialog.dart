
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/button_add_scores.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/navigator_add_subject.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            title: Container(
              padding: EdgeInsets.all(16.sp),
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue900,
              child: Text(
                'Thêm môn học',
                style: ThemeText.bodySemibold
                    .copyWith(color: AppColors.bianca, fontSize: 18.sp),
                textAlign: TextAlign.center,
              ),
            ),
            content: SizedBox(
              height: 190.sp,
              child: Column(
                children: [
                  Expanded(
                    child: ButtonAddScore(
                      subjectName: "Tiếng Anh 1",
                      onPressed: () {
                        Get.to(() => const NavigatorAddSubject(
                              id: "ATCBNN1",
                              name: "Tiếng Anh 1",
                              numberOfCredits: "3",
                            ));
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.blue800,
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ButtonAddScore(
                      subjectName: "Tiếng Anh 2",
                      onPressed: () {
                        Get.to(() => const NavigatorAddSubject(
                              id: "LTCBNN2",
                              name: "Tiếng Anh 2",
                              numberOfCredits: "3",
                            ));
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.blue800,
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ButtonAddScore(
                      subjectName: "Tiếng Anh 3",
                      onPressed: () {
                        Get.to(() => const NavigatorAddSubject(
                              id: "ATCBNN6",
                              name: "Tiếng Anh 3",
                              numberOfCredits: "4",
                            ));
                      },
                    ),
                  ),
                  const Divider(
                    color: AppColors.blue800,
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        });
  }