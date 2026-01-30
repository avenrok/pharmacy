import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/widgets/product_card.dart';
// import 'package:pharmacy/view/search/search_page.dart';

class CategoryProductsPage extends StatelessWidget {
  final String categoryName;

  CategoryProductsPage({super.key, required this.categoryName});

  // Пример товаров для категории
  final List<Product> _categoryProducts = [
    Product(
        name: 'Название товара',
        price: '999,99 ₽',
        oldPrice: '1 299,99 ₽',
        id: 1),
    Product(
        name: 'Название товара',
        price: '999,99 ₽',
        oldPrice: '1 299,99 ₽',
        requiresPrescription: true,
        id: 2),
    Product(
        name: 'Название товара',
        price: '999,99 ₽',
        oldPrice: '1 299,99 ₽',
        id: 3),
    Product(
        name: 'Название товара',
        price: '999,99 ₽',
        oldPrice: '1 299,99 ₽',
        requiresPrescription: true,
        id: 4),
    Product(
        name: 'Название товара',
        price: '999,99 ₽',
        oldPrice: '1 299,99 ₽',
        id: 5),
    Product(
        name: 'Название товара',
        price: '999,99 ₽',
        oldPrice: '1 299,99 ₽',
        requiresPrescription: true,
        id: 6),
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
          onPressed: () {
            Navigator.of(context).pop(); // Возврат на страницу категорий
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75, // Соотношение сторон для карточек
        ),
        itemCount: _categoryProducts.length,
        itemBuilder: (context, index) {
          final product = _categoryProducts[index];
          // Каждая вторая карточка будет акционной для демонстрации красной звезды
          bool showActionStar = index % 2 == 0;
          return ProductCard(
            product: product,
            isAction:
                showActionStar, // Передаем флаг для отображения красной звезды
            isInCart: false,
          );
        },
      ),
    );
  }
}
