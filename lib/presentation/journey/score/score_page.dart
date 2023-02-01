import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/data/remote/score_repository.dart';
import 'package:kit_schedule_v2/domain/models/hive_score_cell.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/popup_menu.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/srores_cell.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_refresh_widget.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/loading_widget.dart';

import '../../../common/config/database/hive_config.dart';
import 'components/header_scores_widget.dart';

class ScorePage extends GetView<ScoreController> {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      backgroundColor: AppColors.bianca,
      body: ValueListenableBuilder(
        valueListenable: getIt<HiveConfig>().hiveScoresCell.listenable(),
        builder: (context, Box<HiveScoresCell> box, _) {
          return Padding(
            padding: EdgeInsets.only(
                left: 16.sp,
                right: 16.sp,
                top: Get.mediaQuery.padding.top + 16.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Điểm của tôi',
                          textAlign: TextAlign.left,
                          style: ThemeText.bodySemibold.s18,
                        ),
                      ),
                      // IconButton(
                      //     padding: EdgeInsets.zero,
                      // onPressed: () async => await controller.onRefresh(),
                      //     icon: Icon(
                      //       Icons.update,
                      //       color: AppColors.blue900,
                      //       size: 24.sp,
                      //     ))
                      const PopUpMenuScores()
                    ],
                  ),
                  Obx(() =>
                      controller.rxScoreLoadedType.value == LoadedType.start
                          ? SizedBox(
                              width: Get.width,
                              height: Get.height -
                                  18.sp -
                                  Get.mediaQuery.padding.top +
                                  16.sp,
                              child: const Center(child: LoadingWidget()))
                          : _buildBody()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 16.sp,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.sp),
                    decoration: const BoxDecoration(
                        color: AppColors.blue100, shape: BoxShape.circle),
                    child: Text(
                      getIt<ScoreRepository>().avgScoresCell()!.isNaN
                          ? '0.0'
                          : (getIt<ScoreRepository>()
                              .avgScoresCell()!
                              .toStringAsFixed(2)),
                      style: ThemeText.bodySemibold.copyWith(fontSize: 25.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.sp),
                    child: Text(
                      controller.studentScores.value?.id ?? '',
                      textAlign: TextAlign.center,
                      style: ThemeText.bodySemibold,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blue800),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderScoresWidget(),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: getIt<HiveConfig>().hiveScoresCell.length,
                      itemBuilder: (context, index) {
                        return
                            // Dismissible(
                            // key: Key((controller.studentScores.scores ?? []).scores[index].id
                            //     .toString()),
                            // onDismissed: (direction) {
                            //   BlocProvider.of<ScoresBloc>(context)
                            //       .add(DeleteScoreEvent(
                            //       scoresState.scores[index]));
                            //   BlocProvider.of<ScoresBloc>(context)
                            //       .add(CalculateGpaScoreEvent());
                            // },
                            //    child:
                            //
                            GestureDetector(
                          onLongPress: () => {
                            getIt<HiveConfig>().hiveScoresCell.deleteAt(index),
                            showTopSnackBar(context,
                                message: 'Xóa môn thành công',
                                type: SnackBarType.done)
                          },
                          onTap: () => showDialog(
                              context: context,
                              builder: (dialogContext) =>
                                  _scoreDetailsDialog(context, index)),
                          child: ScoresCell(
                            subject: getIt<HiveConfig>()
                                    .hiveScoresCell
                                    .getAt(index)!
                                    .name ??
                                '',
                            credits: getIt<HiveConfig>()
                                .hiveScoresCell
                                .getAt(index)!
                                .numberOfCredits
                                .toString(),
                            score: double.parse(getIt<HiveConfig>()
                                    .hiveScoresCell
                                    .getAt(index)!
                                    .avgScore!)
                                .toStringAsFixed(1),
                            letterScore: getIt<HiveConfig>()
                                    .hiveScoresCell
                                    .getAt(index)!
                                    .alphabetScore ??
                                'F',
                          ),
                        );
                        // );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreDetailsDialog(BuildContext context, int index) {
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        vertical: 12.sp,
        horizontal: 16.sp,
      ),
      title: Container(
        padding: EdgeInsets.all(16.sp),
        width: MediaQuery.of(context).size.width,
        color: AppColors.blue900,
        child: Text(
          getIt<HiveConfig>().hiveScoresCell.getAt(index)!.name ?? '',
          style: ThemeText.bodySemibold
              .copyWith(color: AppColors.bianca, fontSize: 18.sp),
        ),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailInfo(context,
                title: 'Điểm thành phần 1',
                info: getIt<HiveConfig>()
                        .hiveScoresCell
                        .getAt(index)!
                        .firstComponentScore ??
                    ''),
            _buildDetailInfo(context,
                title: 'Điểm thành phần 2',
                info: getIt<HiveConfig>()
                        .hiveScoresCell
                        .getAt(index)!
                        .secondComponentScore ??
                    ''),
            _buildDetailInfo(context,
                title: 'Điểm thi cuối kì',
                info: getIt<HiveConfig>()
                        .hiveScoresCell
                        .getAt(index)!
                        .examScore ??
                    ''),
            _buildDetailInfo(context,
                title: 'Điểm tổng kết',
                info:
                    getIt<HiveConfig>().hiveScoresCell.getAt(index)!.avgScore !=
                            null
                        ? double.parse(getIt<HiveConfig>()
                                .hiveScoresCell
                                .getAt(index)!
                                .avgScore!)
                            .toStringAsFixed(1)
                        : ''),
            _buildDetailInfo(context,
                title: 'Điểm chữ',
                info: getIt<HiveConfig>()
                        .hiveScoresCell
                        .getAt(index)!
                        .alphabetScore ??
                    ''),
          ],
        ),
      ],
    );
  }
  // Widget _scoreDetailsDialog(BuildContext context,Score score) {
  //   return SimpleDialog(
  //     titlePadding: EdgeInsets.zero,
  //     contentPadding: EdgeInsets.symmetric(
  //       vertical: 12.sp,
  //       horizontal: 16.sp,
  //     ),
  //     title: Container(
  //       padding: EdgeInsets.all(16.sp),
  //       width: MediaQuery.of(context).size.width,
  //       color: AppColors.blue900,
  //       child: Text(
  //         score.subject?.name ?? '',
  //         style: ThemeText.bodySemibold
  //             .copyWith(color: AppColors.bianca, fontSize: 18.sp),
  //       ),
  //     ),
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           _buildDetailInfo(context,
  //               title: 'Điểm thành phần 1',
  //               info: score.firstComponentScore ?? ''),
  //           _buildDetailInfo(context,
  //               title: 'Điểm thành phần 2',
  //               info: score.secondComponentScore ?? ''),
  //           _buildDetailInfo(context,
  //               title: 'Điểm thi cuối kì', info: score.examScore ?? ''),
  //           _buildDetailInfo(context,
  //               title: 'Điểm tổng kết', info: score.avgScore ?? ''),
  //           _buildDetailInfo(context,
  //               title: 'Điểm chữ', info: score.alphabetScore ?? ''),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildDetailInfo(BuildContext context,
      {required String title, required String info}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.sp),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          text: TextSpan(
            text: '$title: ',
            style: ThemeText.bodySemibold.blue900.s16,
            children: <TextSpan>[
              TextSpan(
                  text: info, style: ThemeText.bodySemibold.blue900.s16.w400()),
            ],
          ),
        ),
      ),
    );
  }
}
