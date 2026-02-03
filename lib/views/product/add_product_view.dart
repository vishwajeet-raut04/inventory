import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
        Get.find<ProductController>();

    final TextEditingController nameController =
        TextEditingController();
    final TextEditingController categoryController =
        TextEditingController();
    final TextEditingController priceController =
        TextEditingController();
    final TextEditingController stockController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // PRODUCT NAME
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.inventory),
              ),
            ),

            const SizedBox(height: 12),

            // CATEGORY
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
              ),
            ),

            const SizedBox(height: 12),

            // PRICE
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixIcon: Icon(Icons.currency_rupee),
              ),
            ),

            const SizedBox(height: 12),

            // STOCK
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stock Quantity',
                prefixIcon: Icon(Icons.numbers),
              ),
            ),

            const SizedBox(height: 24),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Product'),
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      stockController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please fill all required fields',
                    );
                    return;
                  }

                  controller.addProduct(
                    ProductModel(
                      id: DateTime.now().toString(),
                      name: nameController.text,
                      category: categoryController.text,
                      price: double.parse(priceController.text),
                      stock: int.parse(stockController.text),
                      createdAt: DateTime.now(),
                    ),
                  );

                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
