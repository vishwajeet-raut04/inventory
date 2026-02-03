import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';

class ThemeController extends GetxController {
  // Dark mode state
  final RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Load saved theme from local storage
    final savedTheme = StorageService.readData('isDark');

    if (savedTheme != null && savedTheme is bool) {
      isDark.value = savedTheme;

      // Apply theme on app start
      Get.changeThemeMode(
        savedTheme ? ThemeMode.dark : ThemeMode.light,
      );
    }
  }

  // Toggle theme and save preference
  void toggleTheme(bool value) {
    isDark.value = value;

    // Save to SharedPreferences
    StorageService.saveData('isDark', value);

    // Apply theme instantly
    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
