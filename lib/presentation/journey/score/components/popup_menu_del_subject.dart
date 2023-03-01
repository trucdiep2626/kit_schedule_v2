import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class PopUpMenuDelSubject extends StatelessWidget {
  final Function(int?) onSelected;
  final int index;
  const PopUpMenuDelSubject(
      {required this.onSelected, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (_) => <PopupMenuItem<int>>[
        PopupMenuItem(
          value: 1,
          child: Text("Xóa môn học", style: ThemeText.bodySemibold.s16),
        ),
      ],
      onSelected: onSelected,
      child: const Icon(
        Icons.more_vert,
        color: AppColors.blue900,
      ),
    );
  }
}
