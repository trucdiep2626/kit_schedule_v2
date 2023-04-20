import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/constants/app_dimens.dart';
import 'package:schedule/common/utils/export.dart';
import 'package:schedule/presentation/theme/export.dart';
import 'package:schedule/presentation/widgets/export.dart';

void upgradeDialog({
  required BuildContext context,
  required Function() btnUpgrade,
  required String store,
}) {
  AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.info,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    body: Padding(
      padding: EdgeInsets.all(AppDimens.space_12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Thông báo!",
              textAlign: TextAlign.center,
              style: ThemeText.heading2,
            ),
            SizedBox(
              height: AppDimens.height_8,
            ),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "Phiên bản mới của ứng dụng ",
                style: ThemeText.bodyMedium.copyWith(
                  color: AppColors.grey700,
                  height: 1.75,
                  fontSize: 12.sp,
                ),
                children: [
                  TextSpan(
                    text: "Kit Schedule",
                    style: ThemeText.bodyMedium.copyWith(
                      color: AppColors.grey700,
                      fontWeight: FontWeight.bold,
                      height: 1.75,
                      fontSize: 12.sp,
                    ),
                  ),
                  TextSpan(
                    text: " đã có sẵn trên $store.",
                    style: ThemeText.bodyMedium.copyWith(
                      color: AppColors.grey700,
                      height: 1.75,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppDimens.height_8,
            ),
            Text(
              "Vui lòng cập nhật phiên bản mới để có trải nghiệm tốt nhất.",
              textAlign: TextAlign.center,
              style: ThemeText.bodyMedium.copyWith(
                color: AppColors.grey700,
                height: 1.75,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(
              height: AppDimens.height_4,
            ),
          ],
        ),
      ),
    ),
    btnOk: AppTouchable(
      onPressed: btnUpgrade,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.space_20),
          color: AppColors.blue700,
          boxShadow: [
            BoxShadow(
              color: AppColors.charade.withOpacity(0.3),
              blurRadius: AppDimens.space_4,
              spreadRadius: 1,
              offset: Offset(
                0,
                AppDimens.height_4,
              ),
            )
          ],
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 16.sp),
        padding: EdgeInsets.symmetric(vertical: 12.sp),
        child: Text(
          'Cập nhật',
          style: ThemeText.bodySemibold
              .copyWith(color: AppColors.bianca, fontSize: 18.sp),
        ),
      ),
    ),
  ).show();
}
