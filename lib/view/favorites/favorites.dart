import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/view/search/search_page.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // Список избранных товаров (пример данных)
  // В реальном приложении это будет из State Management
  final List<FavoriteItem> _favoriteItems = [
    FavoriteItem(
      product: Product(
          name:
              'Название товара в несколько строк, а также объем или штучность товара',
          price: '999,99 ₽',
          oldPrice: '1 299,99 ₽',
          id: 1),
      quantity: 1,
      requiresPrescription: false,
    ),
    FavoriteItem(
      product: Product(
          name:
              'Название товара в несколько строк, а также объем или штучность товара',
          price: '999,99 ₽',
          oldPrice: '1 299,99 ₽',
          id: 2),
      quantity: 1,
      requiresPrescription: true, // Пример товара по рецепту
    ),
  ];

  // Метод для изменения количества товара
  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQuantity = _favoriteItems[index].quantity + delta;
      if (newQuantity > 0) {
        // Количество не может быть меньше 1
        _favoriteItems[index].quantity = newQuantity;
      } else {
        // Если количество стало 0 или меньше, удаляем из избранного
        _favoriteItems.removeAt(index);
      }
    });
  }

  // Метод для удаления товара из избранного
  void _removeItem(int index) {
    setState(() {
      _favoriteItems.removeAt(index);
    });
  }

  // Метод для добавления товара в корзину из избранного
  void _addToCart(FavoriteItem item) {
    // print('Добавить ${item.product.name} (${item.quantity} шт.) в корзину');
    // Опционально: можно удалить товар из избранного после добавления в корзину
    // _favoriteItems.remove(item);
    // setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Товар "${item.product.name}" добавлен в корзину.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _favoriteItems.length,
            itemBuilder: (context, index) {
              final item = _favoriteItems[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Иконка звездочки "Избранное"
                      GestureDetector(
                        onTap: () => _removeItem(
                            index), // Нажатие на звезду - удаление из избранного
                        child: Image.asset(
                          'lib/res/icons/favorites_add.png', // Иконка заполненной звезды
                          width: 32, // Размер иконки
                          height: 32,
                          // Если нужно изменить цвет
                          // colorFilter: ColorFilter.mode(AppColors.textSecondary, BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Изображение товара
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.success),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Image.asset(
                              "lib/res/icons/tmc.png"), // Изображение товара
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Детали товара
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: AppTextStyles.bodyText
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // Количество и цена
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.success
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: AppColors.success),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _updateQuantity(index, -1),
                                        child: Icon(Icons.remove,
                                            size: 16, color: AppColors.success),
                                      ),
                                      Text(' ${item.quantity} ',
                                          style: AppTextStyles.bodyText
                                              .copyWith(
                                                  color: AppColors.success)),
                                      GestureDetector(
                                        onTap: () => _updateQuantity(index, 1),
                                        child: Icon(Icons.add,
                                            size: 16, color: AppColors.success),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  item.product.price,
                                  style: AppTextStyles.bodyText
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (item
                                .requiresPrescription) // Показываем, если нужен рецепт
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.warning_amber_rounded,
                                        color: AppColors.warning, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Товар отпускается по рецепту',
                                      style: AppTextStyles.hintText
                                          .copyWith(color: AppColors.warning),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 8),
                            // Кнопка "Добавить в корзину"
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _addToCart(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Добавить в корзину',
                                  style: AppTextStyles.bodyText.copyWith(
                                      color: Colors
                                          .white), // Меньший размер шрифта для кнопки в списке
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Вспомогательный класс для элемента избранного
class FavoriteItem {
  final Product product;
  int quantity;
  final bool requiresPrescription;

  FavoriteItem({
    required this.product,
    this.quantity = 1,
    this.requiresPrescription = false,
  });
}
