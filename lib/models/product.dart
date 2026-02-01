class Product {
  final int id;
  final String name;
  final double price;
  final double? oldPrice;
  final int? discountPercentage;
  final bool isActionProduct;
  final String? imageBase64;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    this.discountPercentage,
    this.isActionProduct = false,
    this.imageBase64,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double parsePrice(String? priceString) {
      if (priceString == null || priceString.isEmpty) return 0;
      final cleaned =
          priceString.replaceAll(RegExp(r'[^0-9,]'), '').replaceAll(',', '.');
      return double.tryParse(cleaned) ?? 0;
    }

    return Product(
      id: json['id'],
      name: json['name'],
      price: parsePrice(json['price']),
      oldPrice: parsePrice(json['old_price']),
      discountPercentage: json['discount_percentage'],
      isActionProduct: json['is_action_product'] ?? false,
      imageBase64: json['image_base64'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'old_price': oldPrice,
      'discount_percentage': discountPercentage,
      'is_action_product': isActionProduct,
      'image_base64': imageBase64,
    };
  }
}
