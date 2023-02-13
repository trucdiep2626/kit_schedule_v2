import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

class PopUpMenuDelSubject extends GetView<ScoreController> {
  final int index;
  const PopUpMenuDelSubject({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: const Icon(
        Icons.more_vert,
        color: AppColors.blue900,
      ),
      itemBuilder: (_) => <PopupMenuItem<int>>[
        PopupMenuItem(
            value: 1,
            child: Text("Xóa môn học này", style: ThemeText.bodySemibold.s16)),
      ],
      onSelected: (value) async {
        if (value == 1) {
          getIt<HiveConfig>().hiveScoresCell.deleteAt(index);
          showTopSnackBar(
            context,
            message: 'Xóa môn học thành công',
            type: SnackBarType.done,
          );
        }
      },
    );
  }
}
