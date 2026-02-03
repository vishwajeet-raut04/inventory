import 'package:get/get.dart';
import '../models/sale_model.dart';
import '../controllers/product_controller.dart';

class SalesController extends GetxController {
  final ProductController productController =
      Get.find<ProductController>();

  // All sales (transactions)
  var sales = <SaleModel>[].obs;

  // SELL = only save transaction
  void sell({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
  }) {
    final sale = SaleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: productId,
      productName: productName,
      quantity: quantity,
      price: price,
      total: quantity * price,
      date: DateTime.now(),
    );

    sales.add(sale);
    productController.reduceStock(productId, quantity);

    Get.snackbar(
      'Sold',
      'Product added to sales list',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Total amount
  double totalAmount() {
    return sales.fold(0, (sum, s) => sum + s.total);
  }

  // Clear after bill generation (optional)
  void clearSales() {
    sales.clear();
  }
}
