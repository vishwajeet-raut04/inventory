import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/sales_controller.dart';
import '../../controllers/product_controller.dart';
import '../../services/pdf_service.dart';

class SalesView extends StatelessWidget {
  SalesView({super.key});

  final SalesController salesController =
      Get.find<SalesController>();
  final ProductController productController =
      Get.find<ProductController>();

  final RxString selectedProductId = ''.obs;
  final TextEditingController qtyController =
      TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product select
            Obx(() {
              return DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Select Product'),
                items: productController.productList.map((p) {
                  return DropdownMenuItem(
                    value: p.id,
                    child: Text('${p.name} (Stock: ${p.stock})'),
                  );
                }).toList(),
                onChanged: (v) => selectedProductId.value = v ?? '',
              );
            }),

            const SizedBox(height: 12),

            // Quantity
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Quantity'),
            ),

            const SizedBox(height: 16),

            // SELL BUTTON
            ElevatedButton(
              onPressed: () {
                final product = productController.productList
                    .firstWhereOrNull(
                        (p) => p.id == selectedProductId.value);

                if (product == null) {
                  Get.snackbar('Error', 'Select product');
                  return;
                }

                final qty = int.tryParse(qtyController.text) ?? 0;
                if (qty <= 0 || qty > product.stock) {
                  Get.snackbar('Error', 'Invalid quantity');
                  return;
                }

                salesController.sell(
                  productId: product.id,
                  productName: product.name,
                  quantity: qty,
                  price: product.price,
                );
              },
              child: const Text('Sell'),
            ),

            const SizedBox(height: 24),

            // GENERATE BILL BUTTON
            Obx(() {
              if (salesController.sales.isEmpty) return const SizedBox();

              return ElevatedButton.icon(
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Generate Bill'),
                onPressed: () async {
                  await PdfService.generateFullBillPdf(
                    salesController.sales,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
