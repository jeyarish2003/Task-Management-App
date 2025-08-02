import 'package:get/get.dart';
import 'package:task_management_app/app/modules/task/controller/task_controller.dart';


class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
  }
}