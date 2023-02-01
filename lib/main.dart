import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'common/common_export.dart';
import 'presentation/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  configLocator();
  final hiveSetUp = getIt<HiveConfig>();
  await hiveSetUp.init();
  await SharePreferencesConstants().init();
  runApp(const App());
}
