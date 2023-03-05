import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/gen/assets.gen.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:kit_schedule_v2/common/constants/app_dimens.dart';

class AboutScorePage extends StatelessWidget {
  const AboutScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: AppColors.blue900),
        titleTextStyle: ThemeText.bodySemibold.s18,
        toolbarHeight: AppDimens.appBarHeight,
        title: const Text("Cách tính điểm"),
      ),
      body: SfPdfViewer.asset(
        Assets.docs.aboutScore,
      ),
    );
  }
}
