import 'package:get_it/get_it.dart';
import 'package:schedule/common/config/database/hive_config.dart';
import 'package:schedule/common/constants/shared_preferences_constants.dart';
import 'package:schedule/data/local_repository.dart';
import 'package:schedule/data/remote/school_repository.dart';
import 'package:schedule/data/remote/score_respository.dart';
import 'package:schedule/domain/usecases/personal_usecase.dart';
import 'package:schedule/domain/usecases/school_usecase.dart';
import 'package:schedule/domain/usecases/score_usecase.dart';
import 'package:schedule/presentation/controllers/analytics_controller.dart';
import 'package:schedule/presentation/controllers/app_controller.dart';
import 'package:schedule/presentation/journey/home/home_controller.dart';
import 'package:schedule/presentation/journey/login/login_controller.dart';
import 'package:schedule/presentation/journey/main/main_controller.dart';
import 'package:schedule/presentation/journey/personal/personal_controller.dart';
import 'package:schedule/presentation/journey/score/score_controller.dart';
import 'package:schedule/presentation/journey/setting/setting_controller.dart';
import 'package:schedule/presentation/journey/splash/splash_controller.dart';
import 'package:schedule/presentation/journey/todo/todo_controller.dart';

GetIt getIt = GetIt.instance;

void configLocator() {
  /// Controllers
  getIt.registerLazySingleton<AppController>(() => AppController());
  getIt.registerFactory<SplashController>(
      () => SplashController(getIt<SharePreferencesConstants>()));
  getIt.registerFactory<MainController>(() => MainController(
      getIt<SchoolUseCase>(), getIt<SharePreferencesConstants>()));
  getIt.registerFactory<HomeController>(() => HomeController(
        sharePrefes: getIt<SharePreferencesConstants>(),
        schoolUseCase: getIt<SchoolUseCase>(),
        personalUseCase: getIt<PersonalUsecase>(),
      ));
  getIt.registerFactory<LoginController>(() => LoginController(
      getIt<SchoolUseCase>(), getIt<SharePreferencesConstants>()));
  getIt.registerFactory<TodoController>(
      () => TodoController(getIt<PersonalUsecase>()));
  getIt.registerFactory<ScoreController>(
      () => ScoreController(getIt<SchoolUseCase>(), getIt<ScoreUseCase>()));
  getIt.registerFactory<PersonalController>(() => PersonalController(
      schoolUseCase: getIt<SchoolUseCase>(),
      scoreUseCase: getIt<ScoreUseCase>(),
      personalUsecase: getIt<PersonalUsecase>(),
      sharePreferencesConstants: getIt<SharePreferencesConstants>()));
  getIt.registerFactory<SettingController>(() => SettingController(
      sharePreferencesConstants: getIt<SharePreferencesConstants>()));
  getIt.registerLazySingleton<AnalyticsController>(() => AnalyticsController());

  /// UseCases
  getIt.registerFactory<SchoolUseCase>(
      () => SchoolUseCase(schoolRepository: getIt<SchoolRepository>()));
  getIt.registerFactory<PersonalUsecase>(
      () => PersonalUsecase(getIt<LocalRepository>()));
  getIt.registerFactory<ScoreUseCase>(
      () => ScoreUseCase(getIt<ScoreRepository>()));

  /// Repositories
  getIt.registerFactory<LocalRepository>(
      () => LocalRepository(hiveConfig: getIt<HiveConfig>()));
  getIt.registerFactory<SchoolRepository>(
      () => SchoolRepository(getIt<HiveConfig>()));
  getIt.registerFactory<SharePreferencesConstants>(
      () => SharePreferencesConstants());
  getIt.registerFactory<ScoreRepository>(
      () => ScoreRepository(getIt<HiveConfig>()));
  getIt.registerLazySingleton<HiveConfig>(() => HiveConfig());
}
