import 'package:get/get.dart';
import 'package:task_management_app/app/data/sevices/task_service.dart';
import 'package:task_management_app/app/modules/task/model/task_model.dart';
import 'package:task_management_app/app/routes/app_routes.dart';

class TaskController extends GetxController {
  final TaskService _taskService = TaskService();
  
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<TaskModel?> selectedTask = Rx<TaskModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _listenToTasks();
  }

  void _listenToTasks() {
    _taskService.getTasks().listen((taskList) {
      tasks.value = taskList;
    });
  }

  Future<void> addTask(TaskModel task) async {
    try {
      isLoading.value = true;
      await _taskService.addTask(task);
      Get.back();
      Get.snackbar('Success', 'Task added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      isLoading.value = true;
      await _taskService.updateTask(task);
      Get.back();
      Get.snackbar('Success', 'Task updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _taskService.deleteTask(taskId);
      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task: $e');
    }
  }

  void selectTask(TaskModel task) {
    selectedTask.value = task;
  }

  void navigateToAddTask() {
    Get.toNamed(AppRoutes.ADD_TASK);
  }

  void navigateToEditTask(TaskModel task) {
    selectTask(task);
    Get.toNamed(AppRoutes.EDIT_TASK);
  }
}