import 'package:get/get.dart';
import 'package:kit_schedule_v2/common/common_export.dart';
import 'package:kit_schedule_v2/presentation/journey/todo/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<TodoController>());
  }
}
