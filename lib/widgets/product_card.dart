import 'package:flutter/material.dart';
import 'package:pharmacy/view/search/search_page.dart';
import 'package:pharmacy/theme/app_colors.dart'; 
import 'package:pharmacy/res/styles/styles.dart'; 
import 'package:pharmacy/widgets/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isAction;
  final bool isInCart; 

  const ProductCard({
    super.key,
    required this.product,
    this.isAction = false,
    this.isInCart = false, // По умолчанию false
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Навигация к странице деталей товара
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Место для изображения товара
            Expanded(
              child: Container(
                color: Colors.white, 
                child: Center(
                  child: Image.asset(
                    'lib/res/icons/tmc.png', 
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Название товара
            Text(
              product.name,
              textAlign: TextAlign.center, // Выравнивание названия по центру
              style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4.0),
            // Цены: Теперь в Row для расположения рядом
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Text(
                  // Убираем ' ₽' из строки цены для раздельного отображения числа и значка
                  product.price.split(' ')[0],
                  style: AppTextStyles.headline.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(width: 2.0), // Маленький отступ между числом и значком рубля
                // Значок красного рубля
                Image.asset(
                  'lib/res/icons/valutRu.png',
                  width: 14,
                  height: 14,
                  color: AppColors.error, // Красный цвет для иконки
                ),
                // Отступ между основной и старой ценой
                if (product.oldPrice.isNotEmpty) const SizedBox(width: 8.0),
                // Старая цена
                if (product.oldPrice.isNotEmpty)
                  Text(
                    product.oldPrice,
                    style: AppTextStyles.caption.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey, // Цвет для перечеркнутой цены
                    ),
                  ),
              ],
            ),
            // Пространство для других элементов или просто отступ снизу
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    ));
  }
}