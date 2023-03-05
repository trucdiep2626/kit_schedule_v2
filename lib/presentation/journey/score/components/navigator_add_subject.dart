import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_color.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_text.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_touchable.dart';

class NavigatorAddSubject extends GetView<ScoreController> {
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
    controller.context = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(
            left: 16.sp,
            right: 16.sp,
            top: Get.mediaQuery.padding.top,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.onTapBackScorePage(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.blue800,
                      size: 30,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: Text("Thêm môn học",
                          style: ThemeText.bodySemibold.s18)),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
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
                              child:
                                  nameContainer(numberOfCredits, "Số tín chỉ"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 10.sp),
                              child: textField(
                                errorText: controller
                                    .validateFirstComponentScore.value,
                                controller: controller.firstComponentScore,
                                hintText: "Điểm TP1",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.sp),
                              child: textField(
                                errorText: controller
                                    .validateSecondComponentScore.value,
                                controller: controller.secondComponentScore,
                                hintText: "Điểm TP2",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
                      child: textField(
                        errorText: controller.validateExamScore.value,
                        controller: controller.examScore,
                        hintText: "Điểm thi",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppTouchable(
        onPressed: () => _buttonSaveEng(context),
        outlinedBorder: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(AppDimens.space_20)),
        backgroundColor: AppColors.blue900,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
        padding: EdgeInsets.symmetric(vertical: AppDimens.height_14),
        child: Text(
          'Lưu',
          style: ThemeText.bodySemibold.copyWith(
            color: AppColors.bianca,
            fontSize: AppDimens.space_18,
          ),
        ),
      ),
    );
  }

  Widget textField(
      {required String hintText,
      required TextEditingController controller,
      required String? errorText}) {
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
              border: Border.all(
                color: AppColors.blue800,
                width: 0.5,
              ),
            ),
            child: Center(
              child: TextFormField(
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                ],
                style: ThemeText.bodyMedium.s16,
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            errorText ?? '',
            style: ThemeText.errorText.red,
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
            border: Border.all(
              color: AppColors.blue800,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 12.sp),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: ThemeText.bodyMedium.s16,
            ),
          ),
        ),
      ],
    );
  }

  _buttonSaveEng(BuildContext context) async {
    await controller.addScoreEng(name, id, numberOfCredits);
  }
}
