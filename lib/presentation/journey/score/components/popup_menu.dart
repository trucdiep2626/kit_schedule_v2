import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/text_field_add_score.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class PopUpMenuScores extends GetView<ScoreController> {
  const PopUpMenuScores({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (_) => <PopupMenuItem<int>>[
        PopupMenuItem(
            value: 1,
            child: Text("Thêm môn học", style: ThemeText.bodySemibold.s18)),
        PopupMenuItem(
            value: 2, child: Text("Reload", style: ThemeText.bodySemibold.s18))
      ],
      onSelected: (value) async {
        if (value == 1) {
          controller.displayTextInputDialog();
        } else if (value == 2) {
          await controller.onRefresh();
        }
      },
    );
  }
}
