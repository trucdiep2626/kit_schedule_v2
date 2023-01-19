import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

abstract class WidgetUseCase {
  static const String gpaWidget = "gpa-widget-data";
  static const String scheduleWidget = "gpa-schedule-widget";

  Future<bool?> setGPAWidgetData(GPAWidgetModel gpaWidgetModel);

  Future<bool?> setScheduleWidgetData(List<ScheduleWidgetModel> schedules);

  //
  Future<bool?> clearGPAWidgetData();

  //
  // Future<bool> clearScheduleWidgetData();
  //
  Future<bool?> updateGPAWidgetData();

//
  Future<bool?> updateScheduleWidgetData();
}

class WidgetUseCaseImpl implements WidgetUseCase {
  @override
  Future<bool?> setGPAWidgetData(GPAWidgetModel gpaWidgetModel) {
    return HomeWidget.saveWidgetData(
        WidgetUseCase.gpaWidget, jsonEncode(gpaWidgetModel.toJson()));
  }

  @override
  Future<bool?> updateGPAWidgetData() {
    return HomeWidget.updateWidget(
      iOSName: WidgetUseCase.gpaWidget,
      name: WidgetUseCase.gpaWidget,
    );
  }

  @override
  Future<bool?> clearGPAWidgetData() {
    return HomeWidget.saveWidgetData(WidgetUseCase.gpaWidget, null);
  }

  @override
  Future<bool?> setScheduleWidgetData(List<ScheduleWidgetModel> schedules) {
    final jsonData = schedules.map((e) => e.toJson()).toList();
    print(jsonData);
    return HomeWidget.saveWidgetData(
        "schedule-widget-data", jsonEncode(jsonData));
  }

  @override
  Future<bool?> updateScheduleWidgetData() {
    return HomeWidget.updateWidget(
      iOSName: WidgetUseCase.scheduleWidget,
      name: WidgetUseCase.scheduleWidget,
    );
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
      "score": score,
      "failedSubjects": failedSubjects,
      "passedSubjects": passedSubjects
    };
  }

  late ScheduleWidgetModel model;
}

/// A data model contains information for native home widget
/// [day], [startTime] and [endTime] must be iso8601 standard string
class ScheduleWidgetModel {
  final String? subjectName;
  final DateTime? day;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? room;

  ScheduleWidgetModel({
    this.subjectName,
    this.day,
    this.startTime,
    this.endTime,
    this.room,
  });

  factory ScheduleWidgetModel.fromJson(Map<String, dynamic> json) {
    return ScheduleWidgetModel(
      day: DateTime.tryParse(json["day"] as String? ?? ""),
      startTime: DateTime.tryParse(json["day"] as String? ?? ""),
      endTime: DateTime.tryParse(json["startTime"] as String? ?? ""),
      room: json["room"] as String?,
      subjectName: json["subjectName"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "day": day?.toIso8601String(),
      "startTime": startTime?.toIso8601String(),
      "endTime": endTime?.toIso8601String(),
      "subjectName": subjectName,
      "room": room,
    };
  }
}
