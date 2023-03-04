import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class PopUpMenuSubject extends StatelessWidget {
  final Function(int?) onSelected;
  final Icon icon;
  final String title;
  const PopUpMenuSubject(
      {required this.onSelected,
      required this.title,
      required this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: AppColors.backgroundColor,
      ),
      child: PopupMenuButton<int>(
        itemBuilder: (_) => <PopupMenuItem<int>>[
          PopupMenuItem(
            value: 1,
            child: Text(
              title,
              style: ThemeText.bodySemibold.s16,
            ),
          ),
        ],
        onSelected: onSelected,
        child: icon,
      ),
    );
  }
}
