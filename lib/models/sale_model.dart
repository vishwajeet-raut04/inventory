class SaleModel {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final double total;
  final DateTime date;

  SaleModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
    required this.date,
  });

  // Optional: future use (storage / API)
  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        'quantity': quantity,
        'price': price,
        'total': total,
        'date': date.toIso8601String(),
      };

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
