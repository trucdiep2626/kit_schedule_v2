import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<HomeController>());
  }

}