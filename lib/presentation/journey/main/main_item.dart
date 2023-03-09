import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/utils/analytics_utils.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_page.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_page.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_page.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_page.dart';

enum MainItem {
  home,
  scores,
  todo,
  personal,
}

extension MainItemExtension on MainItem {
  Widget getScreen() {
    switch (this) {
      case MainItem.home:
        return const HomePage();
      case MainItem.scores:
        return const ScorePage();
      case MainItem.todo:
        return const TodoPage();
      case MainItem.personal:
        return PersonalPage();
    }
  }

  int getIndex() {
    switch (this) {
      case MainItem.home:
        return 0;
      case MainItem.scores:
        return 1;
      case MainItem.todo:
        return 2;
      case MainItem.personal:
        return 3;
    }
  }

  IconData getIcon() {
    switch (this) {
      case MainItem.home:
        return Icons.date_range;
      case MainItem.scores:
        return Icons.score_outlined;
      case MainItem.personal:
        return Icons.person;
      case MainItem.todo:
        return Icons.content_paste;
    }
  }

  AnalyticsEventType getEventType() {
    switch (this) {
      case MainItem.home:
        return AnalyticsEventType.viewSchedule;
      case MainItem.scores:
        return AnalyticsEventType.score;
      case MainItem.personal:
        return AnalyticsEventType.todo;
      case MainItem.todo:
        return AnalyticsEventType.personal;
    }
  }
}
