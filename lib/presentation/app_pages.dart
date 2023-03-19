import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/common/injector/bindings/donate_binding.dart';
import 'package:schedule/common/injector/bindings/home_binding.dart';
import 'package:schedule/common/injector/bindings/login_binding.dart';
import 'package:schedule/common/injector/bindings/personal_binding.dart';
import 'package:schedule/common/injector/bindings/score_binding.dart';
import 'package:schedule/common/injector/bindings/setting_binding.dart';
import 'package:schedule/common/injector/bindings/todo_binding.dart';
import 'package:schedule/presentation/journey/donate/views/donate_page.dart';
import 'package:schedule/presentation/journey/login/login_page.dart';
import 'package:schedule/presentation/journey/score/components/about_score_page.dart';
import 'package:schedule/presentation/journey/todo/todo_page.dart';

import 'journey/main/main_screen.dart';
import 'journey/setting/setting_page.dart';
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
    SettingBinding(),
  ]),
  GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding()),
  GetPage(
      name: AppRoutes.todo,
      page: () => const TodoPage(),
      binding: TodoBinding()),
  GetPage(
      name: AppRoutes.score,
      page: () => const LoginPage(),
      binding: ScoreBinding()),
  GetPage(
      name: AppRoutes.personal,
      page: () => const LoginPage(),
      binding: PersonalBinding()),
  GetPage(
    name: AppRoutes.setting,
    page: () => SettingPage(),
    binding: SettingBinding(),
  ),
  GetPage(
    name: AppRoutes.aboutScore,
    page: () => AboutScorePage(),
  ),
  GetPage(
    name: AppRoutes.donate,
    page: () => DonatePage(),
    binding: DonateBinding(),
  ),
];
