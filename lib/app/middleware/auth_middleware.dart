import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/modules/auth/controller/auth_controller.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  @override
  RouteSettings? redirect(String? route) {
    // Allow splash route to pass through
    if (route == AppRoutes.SPLASH) {
      return null;
    }
    
    try {
      final authController = Get.find<AuthController>();
      
      // If auth is not initialized yet, stay on splash
      if (!authController.isInitialized.value) {
        return const RouteSettings(name: AppRoutes.SPLASH);
      }
      
      // If user is not authenticated and trying to access protected routes
      if (!authController.isAuthenticated && 
          route != AppRoutes.LOGIN && 
          route != AppRoutes.SIGNUP) {
        return const RouteSettings(name: AppRoutes.LOGIN);
      }
      
      // If user is authenticated and trying to access auth pages
      if (authController.isAuthenticated && 
          (route == AppRoutes.LOGIN || route == AppRoutes.SIGNUP)) {
        return const RouteSettings(name: AppRoutes.TASK_LIST);
      }
      
      return null;
    } catch (e) {
      // If controller is not found, allow splash
      return const RouteSettings(name: AppRoutes.SPLASH);
    }
  }
}