import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:kit_schedule_v2/domain/usecases/widget_usecase.dart';

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
              keyboardType: TextInputType.number,
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
            )
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
