import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/models/student_schedule_model.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';

class HomeController extends GetxController with MixinController {
  final SchoolUseCase schoolUseCase;

  HomeController({required this.schoolUseCase});

  final MainController mainController = Get.find<MainController>();

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt currentViewIndex = 0.obs;
  Rx<LoadedType> rxHomeLoadedType = LoadedType.start.obs;
  RxList<StudentSchedule> studentSchedule = <StudentSchedule>[].obs;

  Future<void> getScheduleLocal() async {
    rxHomeLoadedType.value = LoadedType.start;
    studentSchedule.clear();
    studentSchedule.addAll(await schoolUseCase.getSchoolScheduleLocal());
    rxHomeLoadedType.value = LoadedType.finish;
  }

  void onChangedView(int newIndex) {
    currentViewIndex.value = newIndex;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getScheduleLocal();
  }

  void onChangedSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }
}
