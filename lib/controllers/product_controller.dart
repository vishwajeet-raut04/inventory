import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/storage_service.dart';

class ProductController extends GetxController {
  var productList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  // ---------------- LOAD ----------------
  void loadProducts() {
    final data = StorageService.readData('products');
    if (data != null) {
      productList.value =
          List<ProductModel>.from(
            data.map((e) => ProductModel.fromJson(e)),
          );
    }
  }

  // ---------------- SAVE ----------------
  void saveProducts() {
    StorageService.saveData(
      'products',
      productList.map((e) => e.toJson()).toList(),
    );
  }

  // ---------------- ADD ----------------
  void addProduct(ProductModel product) {
    productList.add(product);
    saveProducts();
  }

  // ---------------- UPDATE ----------------
  void updateProduct(int index, ProductModel product) {
    productList[index] = product;
    saveProducts();
  }

  // ---------------- DELETE ----------------
  void deleteProduct(int index) {
    productList.removeAt(index);
    saveProducts();
  }

  // ---------------- REDUCE STOCK (FIX) ----------------
  void reduceStock(String productId, int qty) {
    final index =
        productList.indexWhere((p) => p.id == productId);

    if (index != -1) {
      productList[index].stock -= qty;

      // safety check
      if (productList[index].stock < 0) {
        productList[index].stock = 0;
      }

      saveProducts(); // persist update
    }
  }

  // ---------------- TOTAL STOCK ----------------
  int totalStock() {
    return productList.fold(0, (sum, p) => sum + p.stock);
  }

  // ---------------- LOW STOCK ----------------
  List<ProductModel> lowStockProducts() {
    return productList.where((p) => p.stock < 10).toList();
  }
}
