import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_page.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_page.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_page.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_page.dart';

enum MainItem {
  CalendarTabScreenItem,
  ScoresScreenItem,
  TodoScreenItem,
  ProfileScreenItem
}

extension MainItemExtension on MainItem {
  Widget getScreen() {
    switch (this) {
      case MainItem.CalendarTabScreenItem:
        return HomePage();
      case MainItem.ScoresScreenItem:
        return ScorePage();
      case MainItem.TodoScreenItem:
        return TodoPage();
      case MainItem.ProfileScreenItem:
        return PersonalPage();
    }
  }

  int getIndex() {
    switch (this) {
      case MainItem.CalendarTabScreenItem:
        return 0;
      case MainItem.ScoresScreenItem:
        return 1;
      case MainItem.TodoScreenItem:
        return 2;
      case MainItem.ProfileScreenItem:
        return 3;
    }
  }

  IconData getIcon() {
    switch (this) {
      case MainItem.CalendarTabScreenItem:
        return Icons.date_range;
      case MainItem.ScoresScreenItem:
        return Icons.score_outlined;
      case MainItem.ProfileScreenItem:
        return Icons.person;
      case MainItem.TodoScreenItem:
        return Icons.content_paste;
    }
  }
}
