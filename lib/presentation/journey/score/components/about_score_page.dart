import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/gen/assets.gen.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_touchable.dart';
import 'package:kit_schedule_v2/common/constants/app_dimens.dart';
import 'package:pdfx/pdfx.dart';

class AboutScorePage extends StatefulWidget {
  AboutScorePage({Key? key}) : super(key: key);

  @override
  State<AboutScorePage> createState() => _AboutScorePageState();
}

class _AboutScorePageState extends State<AboutScorePage> {
  late PdfControllerPinch controllerPinch;

  @override
  void initState() {
    super.initState();
    controllerPinch = PdfControllerPinch(
        document: PdfDocument.openAsset(Assets.docs.aboutScore));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
        body: Column(
      children: [
        SizedBox(
          height: AppDimens.appBarHeight,
          child: AppBar(
            centerTitle: false,
            leadingWidth: AppDimens.width_32,
            leading: AppTouchable(
              padding: EdgeInsets.only(left: AppDimens.width_12),
              onPressed: Get.back,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.blue900,
              ),
            ),
            backgroundColor: AppColors.backgroundColor,
            iconTheme: const IconThemeData(color: AppColors.blue900),
            titleTextStyle: ThemeText.bodySemibold.s18,
            toolbarHeight: AppDimens.appBarHeight,
            title: const Text("Cách tính điểm"),
          ),
        ),
        Expanded(
          child: PdfViewPinch(
            padding: 0,
            controller: controllerPinch,
          ),
        ),
      ],
    ));
  }
}
