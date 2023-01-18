import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:home_widget/home_widget.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';

import 'common/common_export.dart';
import 'presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  configLocator();
  final hiveSetUp = getIt<HiveConfig>();
  await hiveSetUp.init();
  await SharePreferencesConstants().init();
  await HomeWidget.setAppGroupId("group.kit.schedule");
  runApp(const App());
}
