import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/srores_cell.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_refresh_widget.dart';
import 'package:kit_schedule_v2/presentation/widgets/loading_widget.dart';

import 'components/header_scores_widget.dart';

class ScorePage extends GetView<ScoreController> {
  @override
  Widget build(BuildContext context) {
    return AppRefreshWidget(
      controller: controller.scoreRefreshController,
      onRefresh: controller.onRefresh,
      child: Scaffold(
          backgroundColor: AppColors.secondColor,
          appBar: AppBar(
            backgroundColor: AppColors.secondColor,
            elevation: 0,
            title: Text(
              'Điểm của tôi',
              textAlign: TextAlign.center,
              style: ThemeText.headerStyle2.copyWith(fontSize: 18.sp),
            ),
            leadingWidth: 0,
            // actions: [
            //   IconButton(
            //       onPressed: () async {
            //         final result = await Navigator.pushNamed(
            //             context, RouteList.addScores);
            //         log(result.toString());
            //         if (result is bool && result == true) {
            //           BlocProvider.of<ScoresBloc>(context)
            //               .add(LoadScoresEvent());
            //           BlocProvider.of<ScoresBloc>(context)
            //               .add(CalculateGpaScoreEvent());
            //         }
            //       },
            //       icon: Icon(
            //         Icons.add,
            //         color: AppColors.personalScheduleColor,
            //       )),
            //   SizedBox(
            //     width: 10.w,
            //   )
            // ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Obx(() =>
                controller.rxScoreLoadedType.value == LoadedType.start
                    ? SizedBox(
                        width: Get.width,
                        child: const Center(child: LoadingWidget()))
                    : _buildBody()),
          )),
    );
  }

  Widget _buildBody() {
    return controller.studentScores.value == null
        ? const SizedBox.shrink() // TODO(dieptt): add no data widget
        : SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10.sp),
                          padding: EdgeInsets.all(20.sp),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle),
                          child: Text(
                            (controller.studentScores.value?.avgScore ?? '')
                                .toString(),
                            style: ThemeText.headerStyle2
                                .copyWith(fontSize: 25.sp),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.sp),
                          child: Text(
                            controller.studentScores.value?.id ?? '',
                            textAlign: TextAlign.center,
                            style: ThemeText.headerStyle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.personalScheduleColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HeaderScoresWidget(),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                (controller.studentScores.value?.scores ?? [])
                                    .length,
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
                                  GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (dialogContext) =>
                                        _scoreDetailsDialog(
                                            context,
                                            (controller.studentScores.value
                                                    ?.scores ??
                                                [])[index])),
                                child: ScoresCell(
                                  subject:
                                      (controller.studentScores.value?.scores ??
                                                  [])[index]
                                              .subject
                                              ?.name ??
                                          '',
                                  credits:
                                      (controller.studentScores.value?.scores ??
                                                  [])[index]
                                              .subject
                                              ?.numberOfCredits
                                              .toString() ??
                                          '0',
                                  score:
                                      (controller.studentScores.value?.scores ??
                                                  [])[index]
                                              .avgScore ??
                                          '0.0',
                                  letterScore:
                                      (controller.studentScores.value?.scores ??
                                                  [])[index]
                                              .alphabetScore ??
                                          'F',
                                ),
                              );
                              // );
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget _scoreDetailsDialog(BuildContext context, Score score) {
    return SimpleDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.all(16.sp),
          width: MediaQuery.of(context).size.width,
          color: AppColors.personalScheduleColor2,
          child: Text(
            score.subject?.name ?? '',
            style: ThemeText.titleStyle
                .copyWith(color: AppColors.secondColor, fontSize: 18.sp),
          ),
        ),
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.sp,
              //vertical: WidgetsConstants.paddingVertical
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailInfo(context,
                    title: 'Điểm thành phần 1',
                    info: score.firstComponentScore ?? ''),
                _buildDetailInfo(context,
                    title: 'Điểm thành phần 2',
                    info: score.secondComponentScore ?? ''),
                _buildDetailInfo(context,
                    title: 'Điểm thi cuối kì', info: score.examScore ?? ''),
                _buildDetailInfo(context,
                    title: 'Điểm tổng kết', info: score.avgScore ?? ''),
                _buildDetailInfo(context,
                    title: 'Điểm chữ', info: score.alphabetScore ?? ''),
              ],
            ),
          ),
        ]);
  }

  Widget _buildDetailInfo(BuildContext context,
      {required String title, required String info}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.sp),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: RichText(
          text: TextSpan(
            text: '$title: ',
            style: ThemeText.titleStyle2.copyWith(
                color: AppColors.personalScheduleColor2, fontSize: 16.sp),
            children: <TextSpan>[
              TextSpan(
                  text: info,
                  style: ThemeText.titleStyle2.copyWith(
                      color: AppColors.personalScheduleColor2,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
