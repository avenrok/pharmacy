// lib/view/search/search_page.dart

import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/product_card.dart'; 

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> _recentSearches = [
    'Строка поиска 1',
    'Строка поиска 2',
    'Строка поиска 3',
  ];
  final List<Product> _searchResults = [
    Product(name: 'Название товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽', isNew: true),
    Product(name: 'Название товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽', isNew: false),
    Product(name: 'Название товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽', isNew: true),
    Product(name: 'Название товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽', isNew: false),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Недавние поисковые запросы
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Недавние поиски:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _recentSearches.map((search) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        // print('Выбран недавний поиск: $search');
                      },
                      child: Text(
                        search,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Секции товаров
          _buildProductSection(context, 'Акционный товар', _searchResults.sublist(0, 2), isAction: true),
          const SizedBox(height: 16),
          _buildProductSection(context, 'Товары недели', _searchResults.sublist(0, 2)),
          const SizedBox(height: 16),
          _buildProductSection(context, 'Успей купить!', _searchResults.sublist(0, 2)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }


  Widget _buildProductSection(BuildContext context, String title, List<Product> products, {bool isAction = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              isAction: isAction,
            );
          },
        ),
      ],
    );
  }
}

class Product {
  final String name;
  final String price;
  final String oldPrice;
  final bool isNew; 
  final bool requiresPrescription; 
  final int? discountPercentage; 
  final bool isActionProduct; 

  const Product({
    required this.name,
    required this.price,
    this.oldPrice = '',
    this.isNew = false,
    this.requiresPrescription = false,
    this.discountPercentage,
    this.isActionProduct = false,
  });
}