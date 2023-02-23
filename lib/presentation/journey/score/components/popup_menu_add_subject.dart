import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/button_add_scores.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/text_input_dialog.dart';

class PopUpMenuAddSubject extends GetView<ScoreController> {
  const PopUpMenuAddSubject({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: AppColors.backgroundColor,
      ),
      child: PopupMenuButton<int>(
        child: const Icon(
          Icons.info_outline_rounded,
          color: AppColors.blue900,
        ),
        itemBuilder: (_) => <PopupMenuItem<int>>[
          PopupMenuItem(
            value: 1,
            child: Text("Thêm môn học", style: ThemeText.bodySemibold.s16),
          ),
        ],
        onSelected: (value) async {
          if (value == 1) {
            displayTextInputDialog(context);
          }
        },
      ),
    );
  }
}
