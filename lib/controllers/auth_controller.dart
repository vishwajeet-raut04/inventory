import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() {
    final data = StorageService.readData('loggedIn');
    isLoggedIn.value = data == true;
  }

  // ✅ REGISTER USER (LOCAL)
  void register(String email, String password) {
    StorageService.saveData('user', {
      'email': email,
      'password': password,
    });

    Get.snackbar('Success', 'Account created successfully');
    Get.offAllNamed(AppRoutes.login);
  }

  // ✅ LOGIN WITH VALIDATION
  void login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    final user = StorageService.readData('user');

    if (user == null) {
      Get.snackbar('Error', 'No account found. Please register first');
      return;
    }

    if (user['email'] != email || user['password'] != password) {
      Get.snackbar('Error', 'Invalid email or password');
      return;
    }

    // ✅ Correct credentials
    StorageService.saveData('loggedIn', true);
    isLoggedIn.value = true;

    Get.offAllNamed(AppRoutes.home);
  }

  void logout() {
    StorageService.saveData('loggedIn', false);
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);
  }
}
