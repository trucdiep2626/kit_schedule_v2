import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/covid19_summary_response.dart';
import 'package:kit_schedule_v2/domain/usecases/weather_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';

class HomeController extends GetxController with MixinController {
  final WeatherUseCase weatherUc;

  HomeController({required this.weatherUc});

  @override
  Future<void> onReady() async {
    super.onReady();
    Covid19SummaryGlobalModel globalSummary = await weatherUc.getCovid19SummaryGlobal();
    logger('totalRecovered: ${globalSummary.totalRecovered}');
  }
}