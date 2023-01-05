import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/domain/usecases/personal_usecase.dart';
import 'package:kit_schedule_v2/domain/usecases/school_usecase.dart';
import 'package:kit_schedule_v2/presentation/controllers/mixin/export.dart';
import 'package:kit_schedule_v2/presentation/journey/main/main_controller.dart';

class PersonalController extends GetxController with MixinController {
  final MainController mainController = Get.find<MainController>();
  Rx<LoadedType> rxPersonalLoadedType = LoadedType.finish.obs;

  SchoolUseCase schoolUseCase;
  PersonalUsecase personalUsecase;
  SharePreferencesConstants sharePreferencesConstants;

  PersonalController(
      {required this.schoolUseCase,
      required this.personalUsecase,
      required this.sharePreferencesConstants});

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> logOut() async {
  //  try {
      await schoolUseCase.deleteStudentInfo();
      await schoolUseCase.deleteAllSchoolSchedulesLocal();
      await personalUsecase.deleteAllPersonalSchedulesLocal();
      await await sharePreferencesConstants.setIsLogIn(isLogIn: false);
      Get.offAllNamed(AppRoutes.login);
    // } catch (e) {
    //
    // }
  }
}
