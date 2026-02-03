import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';
import 'services/storage_service.dart';
import 'controllers/theme_controller.dart';

// Views
import 'views/auth/splash_view.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'views/dashboard/dashboard_view.dart';
import 'views/product/product_list_view.dart';
import 'views/product/add_product_view.dart';
import 'views/product/edit_product_view.dart';
import 'views/sales/sales_view.dart';
import 'views/settings/settings_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🌙 Theme Controller (Global)
    final ThemeController themeController =
        Get.put(ThemeController(), permanent: true);

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory Management App',

        // ================= THEME MODE =================
        themeMode: themeController.isDark.value
            ? ThemeMode.dark
            : ThemeMode.light,

        // ================= LIGHT THEME =================
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF7F8FA),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4F46E5),
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        // ================= DARK THEME =================
        darkTheme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
            brightness: Brightness.dark,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF020617),
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFF020617),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
            ),
          ),
        ),

        // ================= INITIAL ROUTE =================
        initialRoute: AppRoutes.splash,

        // ================= GETX ROUTES =================
        getPages: [
          GetPage(name: AppRoutes.splash, page: () => const SplashView()),
          GetPage(name: AppRoutes.login, page: () => const LoginView()),
          GetPage(name: AppRoutes.register, page: () => const RegisterView()),
          GetPage(name: AppRoutes.home, page: () => const DashboardView()),
          GetPage(name: AppRoutes.products, page: () => const ProductListView()),
          GetPage(name: AppRoutes.addProduct, page: () => const AddProductView()),
          GetPage(name: AppRoutes.editProduct, page: () => const EditProductView()),
          GetPage(name: AppRoutes.sales, page: () => SalesView()),
          GetPage(name: AppRoutes.settings, page: () => const SettingsView()),
        ],
      ),
    );
  }
}
