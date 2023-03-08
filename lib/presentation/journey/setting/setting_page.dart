import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kit_schedule_v2/common/constants/enums.dart';
import 'package:kit_schedule_v2/common/injector/locators/app_locator.dart';
import 'package:kit_schedule_v2/common/utils/analytics_utils.dart';

import 'package:kit_schedule_v2/common/utils/app_screen_utils/flutter_screenutils.dart';
import 'package:kit_schedule_v2/presentation/controllers/analytics_controller.dart';

import 'package:kit_schedule_v2/presentation/journey/setting/setting_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/snack_bar/app_snack_bar.dart';

import 'package:kit_schedule_v2/common/utils/export.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      backgroundColor: AppColors.bianca,
      appBar: AppBar(
        backgroundColor: AppColors.blue900,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Cài đặt',
          style: ThemeText.heading2.copyWith(color: AppColors.bianca),
        ),
      ),
      body: Obx(
        () {
          return Column(
            children: [
              _buildListTile(
                onTap: () {},
                title: "Thông báo",
                icon: Icons.notifications_active_outlined,
                trailing: SizedBox(
                  height: 16.h,
                  child: Switch(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: controller.isNotification.value,
                    onChanged: (value) {
                      controller.onChangedNotification(value);
                      controller.notifications();
                    },
                  ),
                ),
              ),
              _buildListTile(
                onTap: () {
                  controller.notifications();
                  _scheduleTimeBottomSheet(context);
                },
                title: "Thông báo trước",
                icon: Icons.timer_outlined,
                trailing: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: controller.timeNotification.value.toString(),
                        style: ThemeText.bodySemibold.blue900,
                        children: [
                          TextSpan(
                            text: " phút",
                            style: ThemeText.bodyMedium.blue900,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AppColors.blue900,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
              _buildListTile(
                onTap: () {},
                title: "Ngôn ngữ",
                icon: Icons.language_outlined,
                trailing: Text(
                  "Tiếng Việt",
                  style: ThemeText.bodyMedium.blue900,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTile(
      {required Function()? onTap,
      required String title,
      required IconData icon,
      Widget? trailing}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.sp),
        color: AppColors.bianca,
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.blue900,
              size: 20.sp,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              title,
              style: ThemeText.bodyMedium.blue900,
            ),
            const Spacer(),
            trailing ??
                SizedBox(
                  height: 38.h,
                ),
          ],
        ),
      ),
    );
  }

  void _scheduleTimeBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (builder) {
        return SizedBox(
          height: 300.h,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.h),
              Text("Thông báo trước",
                  style:
                      ThemeText.bodySemibold.blue900.copyWith(fontSize: 18.sp)),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 61,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("$index phút",
                          style: ThemeText.bodyMedium.blue900),
                      onTap: () {
                        if (controller.isNotification.value) {
                          controller.onChangedTimeNotification(index);
                          controller.notifications();
                        } else {
                          showTopSnackBar(
                            context,
                            message:
                                "Vui lòng bật thông báo trước khi thay đổi thời gian thông báo",
                            type: SnackBarType.error,
                            duration: const Duration(seconds: 4),
                          );
                        }

                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
