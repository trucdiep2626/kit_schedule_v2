import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/presentation/journey/personal/personal_controller.dart';

class PersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<PersonalController>());
  }
}
