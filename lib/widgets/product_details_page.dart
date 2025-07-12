import 'package:flutter/material.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart'; 
import 'package:pharmacy/view/search/search_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _isFavorite = false; // Состояние "Избранное" для этого конкретного товара

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Возвращаемся на предыдущий экран
          },
        ),
        title: const Text('Страница товара'), // Заголовок страницы детализации
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Верхняя часть с изображением товара
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset( 
                  "lib/res/icons/tmc.png", 
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            // Название товара
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.product.name,
                style: AppTextStyles.headline.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            // Цена и старая цена
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Центрируем цены
                children: [
                  Text(
                    widget.product.price,
                    style: AppTextStyles.headline.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  if (widget.product.oldPrice.isNotEmpty) // Показываем старую цену, если она есть
                    Text(
                      widget.product.oldPrice,
                      style: AppTextStyles.bodyText.copyWith(
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textHint,
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (widget.product.isNew) // Если товар акционный, показываем скидку (пример)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('-25%', style: AppTextStyles.bodyText.copyWith(color: Colors.white, fontSize: 12)),
                    )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // "Товар отпускается по рецепту" (если applicable)
            if (true) 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Товар отпускается по рецепту',
                      style: AppTextStyles.bodyText.copyWith(color: AppColors.warning),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            // Подробное описание
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Подробное описание товара, в котором говорится о назначении препарата, его побочных эффектах, а также то, в какой дозировке и когда его следует принимать.',
                style: AppTextStyles.bodyText,
              ),
            ),
            const SizedBox(height: 24),
            // Кнопка "Добавить товар в корзину" и звездочка "Избранное"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Логика добавления в корзину
                        // print('Добавить ${widget.product.name} в корзину');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success, // Зеленая кнопка
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Добавить товар в корзину',
                        style: AppTextStyles.buttonTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                        // print('Product ${widget.product.name} is now favorite: $_isFavorite');
                      });
                    },
                    child: Image.asset(
                      _isFavorite ? 'lib/res/icons/favorites_add.png' : 'lib/res/navigation_bar/image_favorites.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}