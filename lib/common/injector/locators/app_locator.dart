import 'package:get_it/get_it.dart';
import 'package:kit_schedule_v2/data/local_repository.dart';
import 'package:kit_schedule_v2/data/remote/school_repository.dart';
import 'package:kit_schedule_v2/data/remote/weather_repository.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/weather_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/app_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/login/login_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/personal/personal_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/splash/splash_controller.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';

GetIt getIt = GetIt.instance;

void configLocator() {
  /// Controllers
  getIt.registerLazySingleton<AppController>(() => AppController());
  getIt.registerFactory<SplashController>(() => SplashController());
  getIt.registerFactory<MainController>(() => MainController());
  getIt.registerFactory<HomeController>(
      () => HomeController(weatherUc: getIt<WeatherUseCase>()));
  getIt.registerFactory<LoginController>(
      () => LoginController(getIt<SchoolUseCase>()));
  getIt.registerFactory<TodoController>(() => TodoController());
  getIt.registerFactory<ScoreController>(
      () => ScoreController(getIt<SchoolUseCase>()));
  getIt.registerFactory<PersonalController>(() => PersonalController());

  /// UseCases
  getIt.registerFactory<WeatherUseCase>(
      () => WeatherUseCase(weatherRepo: getIt<WeatherRepository>()));
  getIt.registerFactory<SchoolUseCase>(
      () => SchoolUseCase(schoolRepository: getIt<SchoolRepository>()));

  /// Repositories
  getIt.registerFactory<WeatherRepository>(() => WeatherRepository());
  getIt.registerFactory<LocalRepository>(() => LocalRepository());
  getIt.registerFactory<SchoolRepository>(() => SchoolRepository());
}
