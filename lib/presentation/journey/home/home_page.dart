import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/presentation/journey/home/components/calendar_view.dart';
import 'package:schedule/presentation/journey/home/components/schedule_view.dart';
import 'package:schedule/presentation/theme/export.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Obx(() => CalendarView(
                    schedules: controller.studentSchedule.value,
                    personals: controller.personalSchedule.value,
                  )),
              const Expanded(child: ScheduleView()),
            ],
          ),
        ));
  }
}
