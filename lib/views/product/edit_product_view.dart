import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
        Get.find<ProductController>();

    final Map args = Get.arguments;
    final int index = args['index'];
    final ProductModel product = args['product'];

    final TextEditingController nameController =
        TextEditingController(text: product.name);
    final TextEditingController categoryController =
        TextEditingController(text: product.category);
    final TextEditingController priceController =
        TextEditingController(text: product.price.toString());
    final TextEditingController stockController =
        TextEditingController(text: product.stock.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Product Information',
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

            // UPDATE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.update),
                label: const Text('Update Product'),
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

                  controller.updateProduct(
                    index,
                    ProductModel(
                      id: product.id,
                      name: nameController.text,
                      category: categoryController.text,
                      price: double.parse(priceController.text),
                      stock: int.parse(stockController.text),
                      createdAt: product.createdAt,
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
