class ProductModel {
  String id;
  String name;
  String category;
  double price;
  int stock;
  DateTime createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'price': price,
    'stock': stock,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      stock: json['stock'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
