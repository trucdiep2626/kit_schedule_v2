import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/personal_schedule/personal_schedule_view.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/school_schedule/school_schedule_view.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';

class ScheduleView extends GetView<HomeController> {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Obx(() => buildPageView()),
          ],
        ),
      ),
    );
  }

  Widget buildPageView() {
    List<Widget> tabs = [
      SchoolScheduleWidget(
        selectedDate: controller.selectedDate.value,
      ),
      PersonalScheduleWidget(
        selectedDate: controller.selectedDate.value,
      )
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.sp,
        vertical: 20.sp,
      ),
      alignment: Alignment.center,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          aspectRatio: 3 / 2,
          enableInfiniteScroll: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          onPageChanged: (index, reason) {
            controller.onChangedView(index);
          },
        ),
        itemCount: tabs.length,
        itemBuilder: (
          BuildContext context,
          int itemIndex,
          int pageViewIndex,
        ) {
          return tabs[itemIndex];
        },
      ),
    );
  }
}
