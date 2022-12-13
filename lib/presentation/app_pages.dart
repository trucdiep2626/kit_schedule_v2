import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/common/injector/bindings/home_binding.dart';

import 'journey/main/main_screen.dart';
import 'journey/splash/splash_screen.dart';

List<GetPage> myPages = [
  GetPage(name: AppRoutes.splash, page: () => const SplashScreen(), binding: SplashBinding()),
  GetPage(name: AppRoutes.main, page: () => const MainScreen(), bindings: [
    MainBinding(),
    HomeBinding(),
  ]),
];
