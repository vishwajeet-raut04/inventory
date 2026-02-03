import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../routes/app_routes.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
        Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.addProduct);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      body: Obx(
        () {
          if (controller.productList.isEmpty) {
            return const Center(
              child: Text(
                'No products added yet',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // ICON
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: product.stock < 10
                            ? Colors.red.shade100
                            : Colors.indigo.shade100,
                        child: Icon(
                          Icons.inventory_2,
                          color: product.stock < 10
                              ? Colors.red
                              : Colors.indigo,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // PRODUCT INFO
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${product.price} • Stock: ${product.stock}',
                              style: TextStyle(
                                color: product.stock < 10
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ACTIONS
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.toNamed(
                                AppRoutes.editProduct,
                                arguments: {
                                  'index': index,
                                  'product': product,
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Delete Product',
                                middleText:
                                    'Are you sure you want to delete this product?',
                                textConfirm: 'Delete',
                                textCancel: 'Cancel',
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  controller.deleteProduct(index);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
