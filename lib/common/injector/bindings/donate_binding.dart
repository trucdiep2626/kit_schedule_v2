import 'package:get/get.dart';
import 'package:kit_schedule_v2/presentation/journey/donate/controllers/donate_controller.dart';

class DonateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonateController>(
      () => DonateController(),
    );
  }
}
