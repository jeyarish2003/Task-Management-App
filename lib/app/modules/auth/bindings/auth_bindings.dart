import 'package:get/get.dart';
import 'package:task_management_app/app/modules/auth/controller/auth_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}