import 'package:pharmacy/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  bool isSelected;
  final bool requiresPrescription;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.isSelected = false,
    this.requiresPrescription = false,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      isSelected: json['isSelected'] ?? false,
      requiresPrescription: json['requiresPrescription'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'isSelected': isSelected,
      'requiresPrescription': requiresPrescription,
    };
  }
}
