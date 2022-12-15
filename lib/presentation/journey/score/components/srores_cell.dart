import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class ScoresCell extends StatelessWidget {
  const ScoresCell(
      {Key? key,
      required this.subject,
      required this.score,
      required this.letterScore,
      required this.credits})
      : super(key: key);
  final String subject;
  final String credits;
  final String score;
  final String letterScore;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.sp,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom: BorderSide(color: AppColors.personalScheduleColor))),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: scoresWidget(score: subject),
          ),
          Expanded(
            flex: 2,
            child: scoresWidget(score: credits.toString()),
          ),
          Expanded(
            flex: 1,
            child: scoresWidget(score: score.toString()),
          ),
          Expanded(
            flex: 1,
            child: scoresWidget(score: letterScore.toString()),
          ),
        ],
      ),
    );
  }

  Widget scoresWidget({bool isBorderRight = true, required String score}) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: isBorderRight
                      ? AppColors.personalScheduleColor
                      : Colors.transparent))),
      alignment: Alignment.center,
      child: Text(score,
          textAlign: TextAlign.center,
          style: ThemeText.labelStyle.copyWith(fontSize: 12.sp)),
    );
  }
}
