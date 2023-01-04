import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_page.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_item.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_page.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_page.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_page.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';
import 'package:kit_schedule_v2/presentation/widgets/export.dart';

import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  Widget _buildBottomNavigationItemWidget(
    BuildContext context, {
    Function()? onPressed,
    IconData? icon,
    String? title,
    bool isSelected = false,
  }) {
    return Expanded(
      child: AppTouchable(
          height: 50.sp,
          backgroundColor: AppColors.bianca,
          onPressed: onPressed,
          outlinedBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.only(
            top: AppDimens.space_12,
            bottom: MediaQuery.of(context).padding.bottom + 12.sp,
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: isSelected ? AppColors.primary : AppColors.grey,
          )),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.bianca, boxShadow: [
        BoxShadow(blurRadius: 20, color: AppColors.charade.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          child: Row(
            children: List.generate(MainItem.values.length, (index) {
              return Expanded(
                  flex: 1, child: Obx(() => navBarItem(context, index)));
            }),
          ),
        ),
      ),
    );
  }

  Widget navBarItem(
    BuildContext context,
    int index,
  ) {
    final mainItem = MainItem.values.elementAt(index);

    return GestureDetector(
        onTap: () => controller.onChangedNav(index),
        child: SizedBox(
          height: 50.sp,
          child: Icon(
            mainItem.getIcon(),
            color: controller.rxCurrentNavIndex.value == index
                ? AppColors.blue500
                : AppColors.charade,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    final List<Widget> listScreenTab = [
      const HomePage(),
      ScorePage(),
      TodoPage(),
      PersonalPage(),
    ];
    return
        //   WillPopScope(
        // onWillPop: () => controller.onWillPop(context),
        // child:
        Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.rxCurrentNavIndex.value,
            children: listScreenTab,
          )),
      bottomNavigationBar: _buildBottomNavigationBar(context),
//  ),
    );
  }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final List<Widget> pages = [
  //      HomePage(),
  //     ScorePage(),
  //     TodoPage(),
  //     PersonalPage(),
  //   ];
  //
  //   return Scaffold(
  //     backgroundColor: AppColors.grey100,
  //     body: Obx(() => pages[controller.rxCurrentNavIndex.value]),
  //     bottomNavigationBar: _buildBottomNavigationBar(context),
  //   );
  // }
}
