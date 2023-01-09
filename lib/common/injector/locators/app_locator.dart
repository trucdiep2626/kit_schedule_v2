import 'package:get_it/get_it.dart';
import 'package:kit_schedule_v2/common/config/database/hive_config.dart';
import 'package:kit_schedule_v2/common/constants/shared_preferences_constants.dart';
import 'package:kit_schedule_v2/data/local_repository.dart';
import 'package:kit_schedule_v2/data/remote/school_repository.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
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
  getIt.registerFactory<SplashController>(
      () => SplashController(getIt<SharePreferencesConstants>()));
  getIt.registerFactory<MainController>(
      () => MainController(getIt<SchoolUseCase>()));
  getIt.registerFactory<HomeController>(() => HomeController(
        schoolUseCase: getIt<SchoolUseCase>(),
        personalUseCase: getIt<PersonalUsecase>(),
      ));
  getIt.registerFactory<LoginController>(() => LoginController(
      getIt<SchoolUseCase>(), getIt<SharePreferencesConstants>()));
  getIt.registerFactory<TodoController>(
      () => TodoController(getIt<PersonalUsecase>()));
  getIt.registerFactory<ScoreController>(
      () => ScoreController(getIt<SchoolUseCase>()));
  getIt.registerFactory<PersonalController>(() => PersonalController(
      schoolUseCase: getIt<SchoolUseCase>(),
      personalUsecase: getIt<PersonalUsecase>(),
      sharePreferencesConstants: getIt<SharePreferencesConstants>()));

  /// UseCases
  getIt.registerFactory<SchoolUseCase>(
      () => SchoolUseCase(schoolRepository: getIt<SchoolRepository>()));
  getIt.registerFactory<PersonalUsecase>(
      () => PersonalUsecase(getIt<LocalRepository>()));

  /// Repositories
  getIt.registerFactory<LocalRepository>(
      () => LocalRepository(hiveConfig: getIt<HiveConfig>()));
  getIt.registerFactory<SchoolRepository>(
      () => SchoolRepository(getIt<HiveConfig>()));
  getIt.registerFactory<SharePreferencesConstants>(
      () => SharePreferencesConstants());

  getIt.registerLazySingleton<HiveConfig>(() => HiveConfig());
}
