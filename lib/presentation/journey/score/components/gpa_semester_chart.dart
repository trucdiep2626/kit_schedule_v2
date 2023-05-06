import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/common/utils/app_convert.dart';
import 'package:schedule/domain/models/hive_score_cell.dart';
import 'package:schedule/presentation/journey/score/score_controller.dart';
import 'package:schedule/presentation/theme/export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GPASemesterChart extends GetView<ScoreController> {
  final List<HiveScoresCell> hiveScoresCell;
  final Function()? onTap;
  final double avgScore;
  const GPASemesterChart(
      {required this.hiveScoresCell,
      required this.onTap,
      required this.avgScore,
      super.key});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.blue800,
                  size: 30,
                ),
              ),
              Expanded(
                child: SfCircularChart(
                  onSelectionChanged: (selectionArgs) => avgScore,
                  title: ChartTitle(
                      text: "Sơ đồ biểu diễn điểm học kỳ của bạn",
                      textStyle: ThemeText.heading1.s18.blue900,
                      alignment: ChartAlignment.center),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: Center(
                      child: Text(avgScore.toStringAsFixed(2),
                          style: ThemeText.bodySemibold.s24.blue900),
                    ))
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<HiveScoresCell, String>(
                      enableTooltip: true,
                      selectionBehavior: SelectionBehavior(
                        enable: true,
                      ),
                      dataSource: hiveScoresCell
                          .where((element) => element.isSemester ?? false)
                          .toList(),
                      xValueMapper: ((HiveScoresCell data, _) => data.name),
                      yValueMapper: ((HiveScoresCell data, _) =>
                          Convert.letterScoreConvert(data.alphabetScore)),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                  legend: Legend(
                      padding: 0,
                      overflowMode: LegendItemOverflowMode.wrap,
                      position: LegendPosition.bottom,
                      isVisible: true,
                      textStyle: ThemeText.bodyMedium.s14.blue900),
                  onLegendTapped: (legendTapArgs) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
