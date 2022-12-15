import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/score/score_controller.dart';

class ScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<ScoreController>());
  }
}
