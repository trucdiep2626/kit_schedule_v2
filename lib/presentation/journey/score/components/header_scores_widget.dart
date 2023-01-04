import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

class HeaderScoresWidget extends StatelessWidget {
  const HeaderScoresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.sp,
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.blue800))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 6, child: nameBoard('Môn học')),
          Expanded(flex: 2, child: nameBoard('Số tín')),
          Expanded(flex: 2, child: nameBoard('Điểm')) // Expanded(
          //   child: Container(
          //     color: Colors.transparent,
          //     child: Row(
          //       children: [
          //         nameBoard(AppLocalizations.of(context)!.credits),
          //         Expanded(
          //           flex: 2,
          //           child: Container(
          //             color: Colors.transparent,
          //             child: Column(
          //               children: [
          //                 Expanded(
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                         color: Colors.transparent,
          //                         border: Border(
          //                             right: BorderSide(
          //                                 color:
          //                                     AppColors.blue800),
          //                             bottom: BorderSide(
          //                                 color:
          //                                     AppColors.blue800))),
          //                     alignment: Alignment.center,
          //                     child: Text(
          //                       AppLocalizations.of(context)!.score,
          //                       style: ThemeText.headerStyle2
          //                           .copyWith(fontSize: ScoresConstants.scoreFontSize),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                 ),
          //                 // Expanded(
          //                 //     child: Container(
          //                 //   color: Colors.transparent,
          //                 //   child: Row(
          //                 //     children: [nameBoard('Hệ 10'), nameBoard('Hệ 4')],
          //                 //   ),
          //                 // ))
          //               ],
          //             ),
          //           ),
          //         ),
          //      //   nameBoard('Điểm chữ', isBorderRight: false)
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget nameBoard(String title, {bool isBorderRight = true}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              right: BorderSide(
                  color: isBorderRight
                      ? AppColors.blue800
                      : Colors.transparent))),
      alignment: Alignment.center,
      child: Text(
        title,
        style: ThemeText.headerStyle2.copyWith(fontSize: 15.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
