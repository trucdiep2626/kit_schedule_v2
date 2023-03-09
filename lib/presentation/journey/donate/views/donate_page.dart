import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/app_screen_utils/flutter_screenutils.dart';
import 'package:kit_schedule_v2/gen/assets.gen.dart';
import 'package:kit_schedule_v2/presentation/journey/donate/controllers/donate_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_image_widget.dart';

class DonatePage extends GetView<DonateController> {
  const DonatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.blue900, size: 20),
        ),
      ),
      body: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Vui lòng quét mã QR bên dưới',
                style: ThemeText.heading2.copyWith(
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 16.h),
              AppImageWidget(
                width: 220.w,
                path: Assets.icons.imageBank,
              ),
              SizedBox(height: 16.h),
              Text(
                'hoặc',
                style: ThemeText.heading2.copyWith(color: AppColors.blue900),
              ),
              SizedBox(height: 16.h),
              Text.rich(
                TextSpan(
                  text: 'Chuyển khoản qua ngân hàng ',
                  style: ThemeText.heading2
                      .copyWith(color: AppColors.black, fontSize: 14.sp),
                  children: [
                    TextSpan(
                      text: 'MBBank',
                      style: ThemeText.heading2
                          .copyWith(color: AppColors.blue900, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Số tài khoản',
                style: ThemeText.heading2
                    .copyWith(color: AppColors.black, fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 250.w,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.accountNumber,
                      style:
                          ThemeText.heading2.copyWith(color: AppColors.grey600),
                    ),
                    SizedBox(width: 8.w),
                    IconButton(
                      onPressed: () => controller.copyToClipboard(context),
                      icon: const Icon(Icons.copy_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
