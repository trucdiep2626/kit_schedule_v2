import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      child: Stack(
        children: [
          Center(
            child: AppImageWidget(
              path: ImageConstants.pimiLogo,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: AppDimens.paddingBottom),
              child: Obx(
                () {
                  if (controller.rxLoadedType.value == LoadedType.start) {
                    return AppLoadingWidget(
                      width: Get.width * 0.6,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
