import 'package:get_it/get_it.dart';
import 'package:kit_schedule_v2/data/local_repository.dart';
import 'package:kit_schedule_v2/data/remote/weather_repository.dart';
import 'package:kit_schedule_v2/domain/usecases/weather_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/app_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/splash/splash_controller.dart';

GetIt getIt = GetIt.instance;

void configLocator() {
  /// Controllers
  getIt.registerLazySingleton<AppController>(() => AppController());
  getIt.registerFactory<SplashController>(() => SplashController());
  getIt.registerFactory<MainController>(() => MainController());
  getIt.registerFactory<HomeController>(() => HomeController(weatherUc: getIt<WeatherUseCase>()));

  /// UseCases
  getIt.registerFactory<WeatherUseCase>(() => WeatherUseCase(weatherRepo: getIt<WeatherRepository>()));

  /// Repositories
  getIt.registerFactory<WeatherRepository>(() => WeatherRepository());
  getIt.registerFactory<LocalRepository>(() => LocalRepository());
}
