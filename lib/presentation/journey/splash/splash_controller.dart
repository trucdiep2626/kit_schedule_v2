import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

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
