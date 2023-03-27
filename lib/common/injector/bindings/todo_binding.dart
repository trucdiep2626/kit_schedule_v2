import 'package:get/get.dart';
import 'package:schedule/common/common_export.dart';
import 'package:schedule/presentation/journey/todo/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(getIt<TodoController>());
  }
}
