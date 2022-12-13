import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/presentation/journey/home/components/calendar_view.dart';
import 'package:kit_schedule_v2/presentation/theme/export.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body:SafeArea(
          child: Column(
            children: <Widget>[
              CalendarView(),
              Expanded(child: ScheduleWidget()),
            ],
          ),
        ) );
  }
}
