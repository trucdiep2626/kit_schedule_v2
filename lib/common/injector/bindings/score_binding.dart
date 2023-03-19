import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/presentation/journey/score/score_controller.dart';

class ScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<ScoreController>());
  }
}
