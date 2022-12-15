import 'package:get/get.dart';
import 'package:kit_schedule_v2/domain/usecases/weather_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';

class HomeController extends GetxController with MixinController {
  final WeatherUseCase weatherUc;

  HomeController({required this.weatherUc});

  final MainController mainController = Get.find<MainController>();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt currentViewIndex = 0.obs;

  void onChangedView(int newIndex) {
    currentViewIndex.value = newIndex;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void onChangedSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
}
