import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

class SplashController extends GetxController with MixinController {

  SplashController();

  @override
  void onInit() {
    super.onInit();
    setStatusBarStyle(statusBarStyleType: StatusBarStyleType.light);
  }

  @override
  void onReady() {
    super.onReady();
    rxLoadedType.value = LoadedType.start;
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      rxLoadedType.value = LoadedType.finish;
      Get.offAndToNamed(AppRoutes.main);
    });
  }
}
