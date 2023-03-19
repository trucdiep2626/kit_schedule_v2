import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/presentation/journey/main/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<MainController>());
  }
}
