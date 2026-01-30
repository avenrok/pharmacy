import 'dart:convert';
import 'dart:typed_data';

class Product {
  final int id;
  final String name;
  final String price;
  final String oldPrice;
  final bool isNew;
  final bool requiresPrescription;
  final int? discountPercentage;
  final bool isActionProduct;
  final String? imageBase64;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    this.isNew = false,
    this.requiresPrescription = false,
    this.discountPercentage,
    this.isActionProduct = false,
    this.imageBase64,
  });

  // Десериализация (JSON → Dart)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as String,
      oldPrice: json['old_price'] as String,
      isNew: json['is_new'] ?? false,
      requiresPrescription: json['requires_prescription'] ?? false,
      discountPercentage: json['discount_percentage'],
      isActionProduct: json['is_action_product'] ?? false,
      imageBase64: json['image_base64'],
    );
  }

  // Сериализация (Dart → JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'old_price': oldPrice,
      'is_new': isNew,
      'requires_prescription': requiresPrescription,
      'discount_percentage': discountPercentage,
      'is_action_product': isActionProduct,
      'image_base64': imageBase64,
    };
  }

  // Готовые байты для Image.memory
  Uint8List? get imageBytes {
    if (imageBase64 == null || imageBase64!.isEmpty) return null;
    return base64Decode(imageBase64!);
  }
}
