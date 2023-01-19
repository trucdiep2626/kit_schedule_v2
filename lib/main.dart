import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:home_widget/home_widget.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:workmanager/workmanager.dart';

import 'common/common_export.dart';
import 'presentation/app.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print("Task $taskName running");
    return Future.wait<bool?>([
      HomeWidget.updateWidget(
        iOSName: StringConstants.iOSGroupId,
      ),
    ]).then((value) {
      return !value.contains(false);
    });
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  configLocator();
  final hiveSetUp = getIt<HiveConfig>();
  await hiveSetUp.init();
  await SharePreferencesConstants().init();
  await HomeWidget.setAppGroupId(StringConstants.iOSGroupId);
  Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
  runApp(const App());
}
