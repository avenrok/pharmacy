import 'package:flutter/material.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart'; // Предполагаем, что AppTextStyles здесь
import 'package:pharmacy/widgets/category_products.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  // Пример списка категорий
  final List<String> _categories = const [
    'Категория 1',
    'Категория 2',
    'Категория 3',
    'Категория 4',
    'Категория 5',
    'Категория 6',
    'Категория 7',
    'Категория 8',
    'Категория 9',
    'Категория 10',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Список категорий
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Чтобы ListView был внутри SingleChildScrollView
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final categoryName = _categories[index];
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.add, color: AppColors.success), // Иконка "+"
                    title: Text(
                      categoryName,
                      style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textHint),
                    onTap: () {
                      // При нажатии на категорию переходим на страницу товаров этой категории
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsPage(categoryName: categoryName),
                        ),
                      );
                    },
                  ),
                  if (index < _categories.length - 1)
                    const Divider(height: 1, indent: 16, endIndent: 16), // Разделитель между категориями
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}