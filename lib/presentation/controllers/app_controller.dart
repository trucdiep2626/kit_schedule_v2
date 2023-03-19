import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/common/utils/analytics_utils.dart';

import 'mixin/export.dart';

class AppController extends SuperController with MixinController {
  late String uid;


  @override
  void onDetached() {
    logger('---------App State onDetached');
  }

  @override
  void onInactive() {
    logger('---------App State onInactive');
  }

  @override
  void onPaused() {
    logger('---------App State onPaused');
  }

  @override
  void onResumed() {
    logger('---------App State onResumed');
  }
}
