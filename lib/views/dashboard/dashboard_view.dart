import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/product_controller.dart';
import '../../routes/app_routes.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final ProductController productController =
        Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(AppRoutes.settings),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= SUMMARY (GRADIENT CARDS) =================
                Row(
                  children: [
                    _gradientCard(
                      title: 'Total Products',
                      value:
                          productController.productList.length.toString(),
                      icon: Icons.inventory_2,
                      colors: const [Color(0xFF4F46E5), Color(0xFF6366F1)],
                    ),
                    const SizedBox(width: 12),
                    _gradientCard(
                      title: 'Total Stock',
                      value: productController.totalStock().toString(),
                      icon: Icons.stacked_bar_chart,
                      colors: const [Color(0xFF059669), Color(0xFF10B981)],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= LOW STOCK =================
                const Text(
                  'Low Stock Alerts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Expanded(
                  child: productController.lowStockProducts().isEmpty
                      ? const Center(
                          child: Text(
                            'No low stock products 🎉',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              productController.lowStockProducts().length,
                          itemBuilder: (context, index) {
                            final product =
                                productController.lowStockProducts()[index];
                            return Card(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red.shade100,
                                  child: const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                ),
                                title: Text(product.name),
                                subtitle:
                                    Text('Stock: ${product.stock}'),
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 12),

                // ================= QUICK ACTIONS =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _actionButton(
                      icon: Icons.add,
                      label: 'Add',
                      onTap: () => Get.toNamed(AppRoutes.addProduct),
                    ),
                    _actionButton(
                      icon: Icons.list,
                      label: 'Products',
                      onTap: () => Get.toNamed(AppRoutes.products),
                    ),
                    _actionButton(
                      icon: Icons.sell,
                      label: 'Sales',
                      onTap: () => Get.toNamed(AppRoutes.sales),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= GRADIENT CARD =================
  Widget _gradientCard({
    required String title,
    required String value,
    required IconData icon,
    required List<Color> colors,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= ACTION BUTTON =================
  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF4F46E5)),
          ),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    );
  }
}
