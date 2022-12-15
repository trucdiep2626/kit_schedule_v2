import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/covid19_summary_response.dart';
import 'package:kit_schedule_v2/domain/usecases/weather_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';

class PersonalController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxPersonalLoadedType = LoadedType.finish.obs;
  @override
  Future<void> onReady() async {
    super.onReady();
  }
}
