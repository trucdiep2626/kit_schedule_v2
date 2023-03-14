import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_export.dart';
import '../../theme/export.dart';
import '../../widgets/export.dart';

void loginSuccessDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    body: Padding(
      padding: EdgeInsets.all(AppDimens.space_12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Xin chào!",
              textAlign: TextAlign.center,
              style: ThemeText.heading2,
            ),
            SizedBox(
              height: AppDimens.height_8,
            ),
            Text(
              "Bạn vừa đăng nhập thành công trên ứng dụng KIT Schedule.",
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
            Text.rich(
              TextSpan(text: "Lưu ý rằng, KIT Schedule ", children: [
                TextSpan(
                  text: "KHÔNG ",
                  style: ThemeText.bodyMedium.copyWith(
                    color: AppColors.grey700,
                    fontWeight: FontWeight.bold,
                    height: 1.75,
                    fontSize: 12.sp,
                  ),
                ),
                const TextSpan(
                    text:
                        "lưu trữ mật khẩu đăng nhập của sinh viên trên thiết bị cũng như bất kì cơ sở dữ liệu nào khác, "),
                TextSpan(
                  text: "KHÔNG ",
                  style: ThemeText.bodyMedium.copyWith(
                    color: AppColors.grey700,
                    fontWeight: FontWeight.bold,
                    height: 1.75,
                    fontSize: 12.sp,
                  ),
                ),
                const TextSpan(
                    text:
                        "sử dụng tài khoản đăng nhập website QLĐT để trích xuất dữ liệu kết quả học tập.")
              ]),
              style: ThemeText.bodyMedium.copyWith(
                color: AppColors.grey700,
                height: 1.75,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
    btnOk: AppTouchable(
      onPressed: () {
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.space_20),
          color: AppColors.blue900,
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
          'Tôi đã hiểu',
          style: ThemeText.bodySemibold
              .copyWith(color: AppColors.bianca, fontSize: 18.sp),
        ),
      ),
    ),
  ).show();
}
