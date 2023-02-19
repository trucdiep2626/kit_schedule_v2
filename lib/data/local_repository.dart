import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/utils/date_time_format.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';

class LocalRepository {
  // Future<void> setPhone(String phone) async {
  //   await SharePreferencesConstants.prefs
  //       .setString(SharePreferencesConstants.phone, phone);
  // }
  //
  // String getPhone() {
  //   return SharePreferencesConstants.prefs
  //       .getString(SharePreferencesConstants.phone) ??
  //       '';
  // }

  final HiveConfig hiveConfig;

  LocalRepository({required this.hiveConfig});

  Future<void> insertPersonalSchedule(
      PersonalScheduleModel PersonalScheduleModel) async {
    log('${PersonalScheduleModel.createAt}');
    await hiveConfig.personalBox.add(PersonalScheduleModel);
  }

  Future<List<PersonalScheduleModel>> listPerSonIsSyncFailed() async {
    return hiveConfig.personalBox.values
        .where((element) =>
            element.isSynchronized == false || element.updateAt == '0')
        .toList();
  }

  Future<List<PersonalScheduleModel>>
      fetchAllPersonalScheduleRepoLocal() async {
    List<PersonalScheduleModel> result = hiveConfig.personalBox.values
        .where((element) => element.updateAt != '0')
        .toList();

    result.sort((a, b) => _sortScheduleByTime(a, b));

    return result;
  }

  Future<List<PersonalScheduleModel>> fetchAllPersonalScheduleOfDate(
      String date) async {
    final result = hiveConfig.personalBox.values
        .where((element) => element.date == date)
        .toList();
    result.sort((a, b) => a.date!.compareTo(b.date!));
    return result;
  }

  Future<bool> updatePersonalScheduleData(
      PersonalScheduleModel personal) async {
    final result = hiveConfig.personalBox.values;
    for (int i = 0; i < result.length; i++) {
      if (result.elementAt(i).createAt == personal.createAt) {
        await hiveConfig.personalBox.putAt(
            i,
            PersonalScheduleModel(
                id: personal.id,
                date: personal.date,
                name: personal.name,
                timer: personal.timer,
                note: personal.note,
                createAt: personal.createAt,
                updateAt: personal.updateAt,
                isSynchronized: personal.isSynchronized));
        return true;
      }
    }
    return false;
  }

  Future<bool> deletePersonalSchedule(PersonalScheduleModel personal) async {
    var result = hiveConfig.personalBox.values;
    try {
      for (int i = 0; i < result.length; i++) {
        if (result.elementAt(i).createAt == personal.createAt) {
          hiveConfig.personalBox.deleteAt(i);
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> deleteAllPersonalSchedulesLocal() async {
    await hiveConfig.personalBox.clear();
  }

  int _sortScheduleByTime(PersonalScheduleModel a, PersonalScheduleModel b) {
    if (DateTimeFormatter.stringToDate(a.date!)
            .compareTo(DateTimeFormatter.stringToDate(b.date!)) ==
        0) {
      if (a.timer!.compareTo(b.timer!) > 0) {
        return 1;
      } else {
        return -1;
      }
    }
    return DateTimeFormatter.stringToDate(a.date!)
        .compareTo(DateTimeFormatter.stringToDate(b.date!));
  }
}
