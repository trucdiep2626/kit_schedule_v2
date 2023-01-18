import 'dart:convert';

import 'package:home_widget/home_widget.dart';

abstract class WidgetUseCase {
  static const String gpaWidget = "gpa-widget-data";

  Future<bool?> setGPAWidgetData(GPAWidgetModel gpaWidgetModel);

  // Future<bool> setScheduleWidgetData();
  //
  Future<bool?> clearGPAWidgetData();
  //
  // Future<bool> clearScheduleWidgetData();
  //
  Future<bool?> updateGPAWidgetData();
  //
  // Future<bool> updateScheduleWidgetData();
}

class WidgetUseCaseImpl implements WidgetUseCase {
  @override
  Future<bool?> setGPAWidgetData(GPAWidgetModel gpaWidgetModel) {
     return HomeWidget.saveWidgetData(WidgetUseCase.gpaWidget, jsonEncode(gpaWidgetModel.toJson()));
  }

  @override
  Future<bool?> updateGPAWidgetData() {
    return HomeWidget.updateWidget(iOSName: WidgetUseCase.gpaWidget, name: WidgetUseCase.gpaWidget);
  }

  @override
  Future<bool?> clearGPAWidgetData() {
    return HomeWidget.saveWidgetData(WidgetUseCase.gpaWidget, null);
  }
}

class GPAWidgetModel {
  final double? score;
  final int? passedSubjects;
  final int? failedSubjects;

  GPAWidgetModel({
    this.score,
    this.passedSubjects,
    this.failedSubjects,
  });

  factory GPAWidgetModel.fromJson(Map<String, dynamic> json) {
    return GPAWidgetModel(
      score: json["score"] as double?,
      passedSubjects: json["passedSubjects"] as int?,
      failedSubjects: json["failedSubjects"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "score" : score,
      "failedSubjects": failedSubjects,
      "passedSubjects": passedSubjects
    };
  }
}
