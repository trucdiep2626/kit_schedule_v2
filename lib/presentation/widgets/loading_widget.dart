import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;

  const LoadingWidget({Key? key, this.color = AppColors.blue900})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      width: 60.sp,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        key: const ValueKey(LoaderConstants.loaderImageKey),
        backgroundColor: color,
      ),
    );
  }
}

class LoaderConstants {
  static const String loaderBackgroundKey = 'loadingContent';
  static const String loaderImageKey = 'loadingImage';
  static const String loaderTopImageKey = 'topLoadingImage';
  static const String loaderImageContainerKey = 'loadingImageContainer';
  static const double loaderBackgroundOpacity = 0.4;
  static const double loaderRadius = 50.0;
  static const String loaderImage = 'assets/images/loading.gif';
  static const double loaderWidth = 100;
  static const double loaderHeight = 100;
  static const double loaderPaddingTop = 53;
}
