import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/sales_controller.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../routes/app_routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // ================= GLOBAL CONTROLLERS (ONE TIME INIT) =================
    final AuthController authController =
        Get.put(AuthController(), permanent: true);

    Get.put(ProductController(), permanent: true);
    Get.put(SalesController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
    Get.put(ThemeController(), permanent: true);

    // ================= NAVIGATION LOGIC =================
    Future.delayed(const Duration(seconds: 2), () {
      if (authController.isLoggedIn.value) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'Inventory Management App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
