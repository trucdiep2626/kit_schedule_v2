import 'package:kit_schedule_v2/data/local_repository.dart';
import 'package:kit_schedule_v2/domain/models/personal_schedule_model.dart';

class PersonalUsecase {
  final LocalRepository localRepository;

  PersonalUsecase(this.localRepository);

  
  Future<List<PersonalScheduleModel>> fetchAllPersonalScheduleOfDateLocal(
      String date) async {
    return localRepository.fetchAllPersonalScheduleOfDate(date);
  }

  Future<void> deleteAllPersonalSchedulesLocal() async {
    await localRepository.deleteAllPersonalSchedulesLocal();
  }

  Future<bool> deletePersonalScheduleLocal(
      PersonalScheduleModel personal) async {
    return localRepository.deletePersonalSchedule(personal);
  }

  
  Future<List<PersonalScheduleModel>> fetchAllPersonalScheduleRepoLocal() {
    return localRepository.fetchAllPersonalScheduleRepoLocal();
  }

  
  Future<void> insertPersonalScheduleLocal(
      PersonalScheduleModel PersonalScheduleModel) async {
    await localRepository.insertPersonalSchedule(PersonalScheduleModel);
  }

  
  Future<bool> updatePersonalScheduleDataLocal(
      PersonalScheduleModel personal) async {
    return localRepository.updatePersonalScheduleData(personal);
  }

  
  Future<List<PersonalScheduleModel>> listPerSonIsSyncFailed() {
    return localRepository.listPerSonIsSyncFailed();
  }

  // 
  // Future<String> syncPersonalSchoolDataFirebase(
  //     String msv, Map<String, dynamic> data) {
  //   return dataRemote.syncPersonalSchoolDataFirebase(msv, data);
  // }
  //
  // 
  // Future<Map> fetchPersonalSchoolDataFirebase(String msv) {
  //   return dataRemote.fetchPersonalSchoolDataFirebase(msv);
  // }
  //
  // 
  // Future<String> deletePersonalSchoolDataFirebase(String msv, String createAt) {
  //   return dataRemote.deletePersonalSchoolDataFirebase(msv, createAt);
  // }
  //
  // 
  // Future<void> deleteAllPersonalFirebase(String username) {
  //   return dataRemote.deleteAllPersonalFirebase(username);
  // }
}