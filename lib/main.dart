import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/services/local_notification_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'common/common_export.dart';
import 'presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  LocalNotificationService.initNotificationLocal();
  configLocator();
  final hiveSetUp = getIt<HiveConfig>();
  await hiveSetUp.init();
  final pref = getIt<SharePreferencesConstants>();
  await pref.init();
  await pref.clearDataOnReinstall();
  runApp(const App());
}
