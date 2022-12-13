import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/controllers/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<AppController>());
  }

}