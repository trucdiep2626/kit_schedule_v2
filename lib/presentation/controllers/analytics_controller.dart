import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/utils/analytics_utils.dart';

class AnalyticsController extends GetxController {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> logEvent(
    AnalyticsEventType type, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      debugPrint('--------------${type.name}---------');
      await analytics.logEvent(
        name: type.name,
        parameters: parameters,
      );
      debugPrint('-----------------------');
    } on Exception catch (e) {
      debugPrint('------------$e-----------');
    }
  }

  Future<void> logLogin({String? loginMethod}) {
    return analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> setCurrentScreen(String? screenName) {
    debugPrint('------------${screenName ?? ''}-----------');
    return analytics.setCurrentScreen(screenName: screenName);
  }
}
