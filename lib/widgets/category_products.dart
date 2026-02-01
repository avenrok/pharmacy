import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/widgets/product_card.dart';

class CategoryProductsPage extends StatelessWidget {
  final String categoryName;

  CategoryProductsPage({super.key, required this.categoryName});

  // Пример товаров для категории
  final List<Product> _categoryProducts = [
    Product(
        id: 1,
        name: 'Название товара',
        price: 999.99,
        oldPrice: 1299.99,
        isActionProduct: true),
    Product(id: 2, name: 'Название товара', price: 999.99, oldPrice: 1299.99),
    Product(id: 3, name: 'Название товара', price: 999.99),
    Product(id: 4, name: 'Название товара', price: 999.99, oldPrice: 1299.99),
    Product(id: 5, name: 'Название товара', price: 999.99),
    Product(id: 6, name: 'Название товара', price: 999.99, oldPrice: 1299.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(categoryName),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: _categoryProducts.length,
        itemBuilder: (context, index) {
          final product = _categoryProducts[index];
          return ProductCard(
            product: product,
            isInCart: false,
          );
        },
      ),
    );
  }
}
