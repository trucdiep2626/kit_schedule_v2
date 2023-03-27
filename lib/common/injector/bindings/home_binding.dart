import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/presentation/journey/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<HomeController>());
  }

}