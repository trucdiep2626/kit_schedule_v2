import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/common/utils/analytics_utils.dart';
import 'package:schedule/presentation/controllers/analytics_controller.dart';
import 'package:schedule/presentation/controllers/mixin/export.dart';

class SplashController extends GetxController with MixinController {
  SplashController(this.sharedPref);
  final SharePreferencesConstants sharedPref;

  @override
  void onInit() {
    super.onInit();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.light);
  }

  @override
  void onReady() {
    super.onReady();
    rxLoadedType.value = LoadedType.start;
    getIt<AnalyticsController>().logEvent(AnalyticsEventType.appLaunched);
    final isLogin = sharedPref.getIsLogIn();
    rxLoadedType.value = LoadedType.finish;
    if(isLogin)
      {
        Get.offAndToNamed(AppRoutes.main);
      }
    else{
      Get.offAndToNamed(AppRoutes.login);
    }
  }
}
