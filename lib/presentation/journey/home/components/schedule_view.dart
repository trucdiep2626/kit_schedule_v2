import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/personal_schedule/personal_schedule_view.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/school_schedule/school_schedule_view.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';

class ScheduleView extends GetView<HomeController> {
  //final PageController _controller = PageController();

  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final circleShape = Shape(
      size: 8,
      shape: DotShape.Circle,
      spacing: 8,
    );*/
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Obx(() => buildPageView()),
            //todo buildExampleIndicatorWithShapeAndBottomPos(circleShape, 8),
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
      PersonalScheduleWidget()
    ];

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
        alignment: Alignment.center,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            // enableInfiniteScroll: false,
            aspectRatio: 3 / 2,
            // viewportFraction: 1,
            enableInfiniteScroll: true,

            //   enlargeCenterPage: true,
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
        )

        // PageView.builder(
        //   physics: AlwaysScrollableScrollPhysics(),
        //   onPageChanged: controller.onChangedView,
        //   controller: _controller,
        //   itemBuilder: (BuildContext context, index) {
        //     return Obx(() {
        //       return controller.currentViewIndex.value == 0
        //           ? SchoolScheduleWidget(
        //               selectedDate: controller.selectedDate.value,
        //             )
        //           : PersonalScheduleWidget();
        //       // return LoadingWidget();
        //     });
        //
        //     //       else if (state is UpdateScheduleDaySuccessState) {
        //     //         if (index == 0)
        //     //           return SchoolScheduleWidget(state: state);
        //     //         else
        //     //           return PersonalScheduleWidget(state: state);
        //     //       } else {
        //     //         return SizedBox();
        //     //       }
        //     //     },
        //     //   );
        //   },
        //   itemCount: 2,
        // ),
        );
  }

/*Widget buildExampleIndicatorWithShapeAndBottomPos(
      */ /*Shape shape,*/ /* double bottomPos) {
    return Positioned(
      bottom: bottomPos,
      left: 0,
      right: 0,
      child: WormIndicator(
        length: 2,
        controller: _controller,
        shape: shape,
      ),
    );
  }*/
}
