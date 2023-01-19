import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:kit_schedule_v2/common/utils/app_convert.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/widget_usecase.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:workmanager/workmanager.dart';

class DemoWidget extends StatefulWidget {
  const DemoWidget({Key? key}) : super(key: key);

  @override
  State<DemoWidget> createState() => _DemoWidgetState();
}

class _DemoWidgetState extends State<DemoWidget> {
  final WidgetUseCase widgetUseCase = WidgetUseCaseImpl();

  double? _score;
  int? _passed, _failed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: _onScoreChanged,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              onChanged: _onFailedChanged,
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: _onPassedChanged,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: _onPressed, child: Text("Set")),
            ElevatedButton(
              onPressed: () {
                widgetUseCase.clearGPAWidgetData();
              },
              child: Text("Clear"),
            ),
            
            ElevatedButton(onPressed: () async {
              final schedules = <ScheduleWidgetModel>[];
              for (StudentSchedule e in Get.find<HomeController>().studentSchedule) {
                final lessons = e.lesson?.split(",");
                final scheduleWidgetModel = ScheduleWidgetModel(
                  day: Convert.convertScheduleTime(
                    e.day,
                  ),
                  startTime: Convert.convertScheduleTime(
                    e.day,
                    Convert.startTimeLessonMap[lessons?.first ?? "0"],
                  ),
                  endTime: Convert.convertScheduleTime(
                    e.day,
                    Convert.endTimeLessonMap[lessons?.last ?? "0"],
                  ),
                  subjectName: e.subjectName,
                  room: e.room,
                );
                schedules.add(scheduleWidgetModel);
              }
              widgetUseCase.setScheduleWidgetData(schedules).then((value) {
                print(value);
                widgetUseCase.updateGPAWidgetData().then(print);
              });
            }, child: Text("bgr")),
            ElevatedButton(onPressed: () {
              HomeWidget.getWidgetData("schedule-widget-data", defaultValue: "No data").then(print);
            }, child: Text("Get"))
          ],
        ),
      ),
    );
  }

  void _onScoreChanged(String value) {
    try {
      _score = double.parse(value);
    } on Exception {
      _score = null;
    }
  }

  void _onPressed() {
    widgetUseCase.setGPAWidgetData(GPAWidgetModel(
      score: _score,
      passedSubjects: _passed,
      failedSubjects: _failed,
    ));
    widgetUseCase.updateGPAWidgetData();
  }

  void _onFailedChanged(String value) {
    try {
      _failed = int.parse(value);
    } on Exception {
      _failed = null;
    }
  }

  void _onPassedChanged(String value) {
    try {
      _passed = int.parse(value);
    } on Exception {
      _passed = null;
    }
  }
}
