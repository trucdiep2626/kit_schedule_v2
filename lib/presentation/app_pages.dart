import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/injector/bindings/home_binding.dart';
import 'package:kit_schedule_v2/common/injector/bindings/login_binding.dart';
import 'package:kit_schedule_v2/common/injector/bindings/personal_binding.dart';
import 'package:kit_schedule_v2/common/injector/bindings/score_binding.dart';
import 'package:kit_schedule_v2/common/injector/bindings/todo_binding.dart';
import 'package:kit_schedule_v2/presentation/journey/login/login_page.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_page.dart';

import 'journey/main/main_screen.dart';
import 'journey/splash/splash_screen.dart';

List<GetPage> myPages = [
  GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding()),
  GetPage(name: AppRoutes.main, page: () => const MainScreen(), bindings: [
    MainBinding(),
    HomeBinding(),
    TodoBinding(),
    ScoreBinding(),
    PersonalBinding(),
  ]),
  GetPage(
      name: AppRoutes.login, page: () => LoginPage(), binding: LoginBinding()),
  GetPage(name: AppRoutes.todo, page: () => TodoPage(), binding: TodoBinding()),
  GetPage(
      name: AppRoutes.score, page: () => LoginPage(), binding: ScoreBinding()),
  GetPage(
      name: AppRoutes.personal,
      page: () => LoginPage(),
      binding: PersonalBinding()),
];
