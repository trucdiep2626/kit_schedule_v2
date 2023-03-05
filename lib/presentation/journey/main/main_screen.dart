import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_page.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_item.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_page.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_page.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_page.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({Key? key}) : super(key: key);

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bianca,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: AppColors.charade.withOpacity(0.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 8.sp,
          ),
          child: Row(
            children: List.generate(
              MainItem.values.length,
              (index) {
                return Expanded(
                  flex: 1,
                  child: Obx(
                    () => navBarItem(
                      context,
                      index,
                    ),
                  ),
                );
              },
            ),
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

    return IconButton(
      splashRadius: AppDimens.space_12,
        onPressed: () async => await controller.onChangedNav(index),
        icon: Icon(
            mainItem.getIcon(),
            color: controller.rxCurrentNavIndex.value == index
                ? AppColors.blue500
                : AppColors.charade,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    final List<Widget> listScreenTab = [
      const HomePage(),
      const ScorePage(),
      const TodoPage(),
      PersonalPage(),
    ];
    return
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

}
