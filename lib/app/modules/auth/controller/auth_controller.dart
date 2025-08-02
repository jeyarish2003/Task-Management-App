import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/data/sevices/firebase_auth.dart';
import 'package:task_management_app/app/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.put(AuthService());

  final RxBool isLoading = false.obs;
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isInitialized = false.obs;

  bool get isAuthenticated => user.value != null;

  @override
  void onInit() {
    print("AuthController initialized");
    super.onInit();
    _initializeAuth();
  }

  void _initializeAuth() async {
    // Add a small delay to ensure Firebase is properly initialized
    await Future.delayed(Duration(milliseconds: 500));

    user.value = _authService.currentUser;
    isInitialized.value = true;

    print("User initialized: ${user.value}");
    // Navigate based on initial auth state
    if (user.value != null) {
      print("Task page");
      Get.offAllNamed(AppRoutes.TASK_LIST);
    } else {
      print("Login");
      Get.offAllNamed(AppRoutes.LOGIN);
    }

    // Listen to auth state changes
    _authService.authStateChanges.listen((User? newUser) {
      if (newUser != user.value) {
        user.value = newUser;
        if (newUser == null) {
          Get.offAllNamed(AppRoutes.LOGIN);
        } else {
          Get.offAllNamed(AppRoutes.TASK_LIST);
        }
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _authService.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
