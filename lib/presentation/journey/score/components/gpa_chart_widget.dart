import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/extensions/number_extension.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_color.dart';
import 'package:kit_schedule_v2/presentation/theme/theme_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GPACharWidget extends StatelessWidget {
  const GPACharWidget({
    Key? key,
    this.score,
  }) : super(key: key);

  final double? score;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          axisLineStyle: const AxisLineStyle(
            cornerStyle: CornerStyle.bothCurve
          ),
          showLabels: false,
          canScaleToFit: true,
          startAngle: 120,
          endAngle: 60,
          maximum: 4,
          minimum: 0,
          pointers: [
            RangePointer(
              value: score ?? 0.0,
              color: AppColors.blue900,
              cornerStyle: CornerStyle.bothCurve,
            ),
            MarkerPointer(
              value: score ?? 0.0,
              markerOffset: -10,
            ),

          ],
          annotations: [
            GaugeAnnotation(
              axisValue: 2.0,
              angle: 90,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "GPA",
                    style: ThemeText.bodyRegular,
                  ),
                  Text(
                    score?.toString() ?? "0.0",
                    style: ThemeText.heading1.s40,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppDimens.height_4,
                  ),
                  Text(
                    score?.gpaTextScore ?? "",
                    style: ThemeText.heading3,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
