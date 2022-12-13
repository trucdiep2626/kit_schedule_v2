import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/data/api_constans.dart';
import 'package:kit_schedule_v2/domain/models/base_response.dart';

class WeatherRepository {
  Future<Map<String, dynamic>> getCovid19Summary() async {
    var baseRes = await ApiClient().request(path: ApiConstants.getCovid19Summary);
    return baseRes.data as Map<String, dynamic>;
  }
}