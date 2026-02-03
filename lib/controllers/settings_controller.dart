import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

class SettingsController extends GetxController {

  void clearAllData() async {
    await StorageService.clearAll();
    Get.offAllNamed(AppRoutes.login);
  }

  void logout() {
    StorageService.clearAll();
    Get.offAllNamed(AppRoutes.login);
  }
}
