import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_app/app/modules/task/controller/task_controller.dart';
import 'package:task_management_app/app/widgets/custom_button.dart';
import 'package:task_management_app/app/widgets/custom_text_field.dart';


class EditTaskPage extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final RxString selectedStatus;

  EditTaskPage() {
    final task = taskController.selectedTask.value!;
    _titleController = TextEditingController(text: task.title);
    _descriptionController = TextEditingController(text: task.description);
    selectedStatus = task.status.obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Task Title',
                hint: 'Enter task title',
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                label: 'Task Description',
                hint: 'Enter task description',
                controller: _descriptionController,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedStatus.value,
                      isExpanded: true,
                      items: ['Pending', 'Completed']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          selectedStatus.value = value;
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Obx(
                () => CustomButton(
                  text: 'Update Task',
                  onPressed: () => _updateTask(),
                  isLoading: taskController.isLoading.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTask() {
    if (_formKey.currentState!.validate()) {
      final currentTask = taskController.selectedTask.value!;
      final updatedTask = currentTask.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        status: selectedStatus.value,
      );
      taskController.updateTask(updatedTask);
    }
  }
}