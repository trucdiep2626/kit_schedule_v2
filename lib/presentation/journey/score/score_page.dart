import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/score_model.dart';
import 'package:kit_schedule_v2/presentation/journey/score/components/gpa_chart_widget.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_expansion_panel_list.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_loading_widget.dart';
import 'package:kit_schedule_v2/presentation/widgets/app_touchable.dart';

class ScorePage extends GetView<ScoreController> {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () {
          return AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: controller.rxLoadedType.value == LoadedType.start
                ? Center(
                    child: AppLoadingWidget(
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      _buildHeader(),
                      _buildSubjectTableHeader(),
                      if (!isNullEmpty(controller.rxStudentScores))
                        _buildScoreTableData(),
                    ],
                  ),
          );

        },
      ),
    );
  }

  SliverList _buildScoreTableData() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final scores = controller.rxStudentScores.value?.scores ?? [];
          if (scores.isEmpty) {
            return SizedBox(
              height: AppDimens.height_80,
              child: const Center(
                child: Text("Không có dữ liệu"),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.all(AppDimens.space_16).copyWith(top: 0),
            child: Obx(
              () => AppExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.only(top: AppDimens.height_8),
                dividerColor: AppColors.blue100,
                elevation: 0,
                children: [
                  for (int i = 0; i < scores.length; i++)
                    _buildScoreCell(i, controller.rxExpandedList[i], scores[i])
                ],
                expansionCallback: controller.setExpandedCell,
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  SliverAppBar _buildHeader() {
    return SliverAppBar(
      centerTitle: false,
      backgroundColor: AppColors.backgroundColor,
      pinned: true,
      floating: false,
      expandedHeight:
          Get.height > 800 ? AppDimens.height_220 : AppDimens.height_260,
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async => await controller.onRefresh(),
          icon: Icon(
            Icons.update,
            color: AppColors.blue900,
            size: AppDimens.space_24,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.info_outline_rounded,
            color: AppColors.blue900,
            size: AppDimens.height_24,
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Column(
          children: [
            SizedBox(
              height: AppDimens.height_90,
            ),
            SizedBox(
              height: Get.height > 800
                  ? AppDimens.height_160
                  : AppDimens.height_180,
              child: GPACharWidget(
                score: controller.rxStudentScores.value?.avgScore,
              ),
            ),
          ],
        ),
      ),
      title: Text(
        'Điểm của bạn',
        style: ThemeText.bodySemibold.s18,
      ),
    );
  }

  ExpansionPanel _buildScoreCell(int index, bool isExpanded, Score score) {
    return ExpansionPanel(
      canTapOnHeader: true,
      backgroundColor:
          isExpanded ? AppColors.transparent : AppColors.backgroundColor,
      isExpanded: isExpanded,
      headerBuilder: (context, isExpanded) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.width_12),
          decoration: BoxDecoration(
            color: isExpanded
                ? AppColors.blue100.withOpacity(0.5)
                : AppColors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimens.space_8),
              topRight: Radius.circular(AppDimens.space_8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  score.subject?.name ?? "Unknown",
                  style: ThemeText.bodySemibold,
                ),
              ),
              if (!isExpanded) ...[
                SizedBox(
                  width: AppDimens.width_12,
                ),
                SizedBox(
                  width: AppDimens.width_40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isExpanded ? "" : score.alphabetScore ?? "?",
                      textAlign: TextAlign.start,
                      style: ThemeText.heading2,
                    ),
                  ),
                )
              ]
            ],
          ),
        );
      },
      body: AppTouchable(
        onPressed: () => controller.setExpandedCell(index, isExpanded),
        child: Container(
          padding: EdgeInsets.all(AppDimens.space_12)
              .copyWith(top: AppDimens.height_8),
          decoration: BoxDecoration(
            color: isExpanded
                ? AppColors.blue100.withOpacity(0.5)
                : AppColors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(AppDimens.space_8),
              bottomRight: Radius.circular(AppDimens.space_8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSubjectInfoRow("Mã môn học", score.subject?.id),
              _buildSubjectInfoRow(
                "Số tin chỉ",
                score.subject?.numberOfCredits?.toString(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "TP 1",
                        style: ThemeText.description
                            .copyWith(color: AppColors.blue600),
                      ),
                      SizedBox(
                        height: AppDimens.height_4,
                      ),
                      Text(
                        score.firstComponentScore ?? "?",
                        style: ThemeText.heading2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "TP 2",
                        style: ThemeText.description
                            .copyWith(color: AppColors.blue600),
                      ),
                      SizedBox(
                        height: AppDimens.height_4,
                      ),
                      Text(
                        score.secondComponentScore ?? "?",
                        style: ThemeText.heading2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "HK",
                        style: ThemeText.description
                            .copyWith(color: AppColors.blue600),
                      ),
                      SizedBox(
                        height: AppDimens.height_4,
                      ),
                      Text(
                        score.examScore ?? "?",
                        style: ThemeText.heading2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "TK",
                        style: ThemeText.description
                            .copyWith(color: AppColors.blue600),
                      ),
                      SizedBox(
                        height: AppDimens.height_4,
                      ),
                      Text(
                        score.avgScore ?? "?",
                        style: ThemeText.heading2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Đ. chữ",
                        style: ThemeText.description
                            .copyWith(color: AppColors.blue600),
                      ),
                      SizedBox(
                        height: AppDimens.height_4,
                      ),
                      Text(
                        score.alphabetScore ?? "?",
                        style: ThemeText.heading2,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectInfoRow(String field, String? description) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.height_8),
      child: Text.rich(
        TextSpan(
          text: "$field: ",
          style: ThemeText.description.copyWith(color: AppColors.black),
          children: [
            TextSpan(
              text: description ?? "None",
              style:
                  ThemeText.description.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSubjectTableHeader() {
    return SliverAppBar(
      pinned: true,
      collapsedHeight:
          Get.height > 800 ? AppDimens.height_64 : AppDimens.height_112,
      backgroundColor: AppColors.backgroundColor,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space_16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Số môn hoàn thành",
                      style: ThemeText.bodyRegular
                          .copyWith(color: AppColors.black),
                    ),
                    SizedBox(
                      height: AppDimens.space_8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: AppDimens.space_24,
                          color: AppColors.blue800,
                        ),
                        SizedBox(
                          width: AppDimens.width_4,
                        ),
                        Text(
                          (controller.rxStudentScores.value?.passedSubjects ??
                                  0)
                              .toString(),
                          style: ThemeText.heading2.s24,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Số môn chưa đạt",
                      style: ThemeText.bodyRegular
                          .copyWith(color: AppColors.black),
                    ),
                    SizedBox(
                      height: AppDimens.height_8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: AppDimens.height_24,
                          color: AppColors.blue800,
                        ),
                        SizedBox(
                          width: AppDimens.space_4,
                        ),
                        Text(
                          (controller.rxStudentScores.value?.failedSubjects ??
                                  0)
                              .toString(),
                          style: ThemeText.heading2.s24,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.space_12,
              ).copyWith(
                top: AppDimens.space_24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Môn học",
                      style: ThemeText.heading4,
                    ),
                  ),
                  SizedBox(
                    width: AppDimens.width_56,
                    child: Text(
                      "Điểm",
                      style: ThemeText.heading4,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              indent: 0,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
