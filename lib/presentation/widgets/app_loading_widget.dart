import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/gen/assets.gen.dart';

import 'app_image_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  final double? width;

  const AppLoadingWidget({Key? key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AppImageWidget(
        path: Assets.images.kitScheduleLogo.path,
      ),
    );
  }
}
