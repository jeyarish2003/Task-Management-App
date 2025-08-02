import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/middleware/auth_middleware.dart';
import 'package:task_management_app/app/modules/auth/bindings/auth_bindings.dart';
import 'package:task_management_app/app/modules/auth/views/login_page.dart';
import 'package:task_management_app/app/modules/auth/views/signup_page.dart';
import 'package:task_management_app/app/modules/task/binding/task_binding.dart';
import 'package:task_management_app/app/modules/task/view/add_task_page.dart';
import 'package:task_management_app/app/modules/task/view/edit_task_page.dart';
import 'package:task_management_app/app/modules/task/view/task_list_page.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.TASK_LIST;

  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: AuthBinding(),
      // No middleware for splash page
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignupPage(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.TASK_LIST,
      page: () => TaskListPage(),
      bindings: [AuthBinding(), TaskBinding()],
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.ADD_TASK,
      page: () => AddTaskPage(),
      binding: TaskBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.EDIT_TASK,
      page: () => EditTaskPage(),
      binding: TaskBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Task Manager',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
