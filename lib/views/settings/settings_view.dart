import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Get.find<SettingsController>();
    final ThemeController themeController =
        Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= APP INFO =================
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.store, color: Colors.white),
                ),
                title: const Text(
                  'Inventory Management App',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Offline Inventory System'),
              ),
            ),

            const SizedBox(height: 20),

            // ================= DARK MODE =================
            Card(
              child: Obx(
                () => SwitchListTile(
                  value: themeController.isDark.value,
                  onChanged: themeController.toggleTheme,
                  title: const Text('Dark Mode'),
                  secondary: const Icon(Icons.dark_mode),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ================= CLEAR ALL DATA =================
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                title: const Text('Clear All Data'),
                subtitle:
                    const Text('Remove all products and sales data'),
                trailing:
                    const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.defaultDialog(
                    title: 'Confirm Action',
                    middleText:
                        'Are you sure you want to clear all data?',
                    textConfirm: 'Yes, Clear',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back();
                      settingsController.clearAllData();
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ================= LOGOUT =================
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                trailing:
                    const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: settingsController.logout,
              ),
            ),

            const Spacer(),

            // ================= FOOTER =================
            const Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 6),
            const Text(
              'Developed by Vishwajeet Mahadev Raut',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
