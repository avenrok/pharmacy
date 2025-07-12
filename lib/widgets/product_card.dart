import 'package:flutter/material.dart';
import 'package:pharmacy/view/search/search_page.dart'; 
import 'package:pharmacy/theme/app_colors.dart'; // Импорт цветов
import 'package:pharmacy/res/styles/styles.dart'; // Импорт стилей текста


class ProductCard extends StatelessWidget { 
  final Product product;
  final bool isAction; // Флаг для акционных товаров

  const ProductCard({
    super.key,
    required this.product,
    this.isAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    "lib/res/icons/tmc.svg",
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  product.name, // Используем product напрямую
                  style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      product.price,
                      style: AppTextStyles.headline.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product.oldPrice,
                      style: AppTextStyles.bodyText.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textHint,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.success),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Row(
                        children: [
                          Icon(Icons.remove, size: 16, color: AppColors.success),
                          Text(' 999 ', style: AppTextStyles.bodyText.copyWith(color: AppColors.success)),
                          Icon(Icons.add, size: 16, color: AppColors.success),
                        ],
                      ),
                    ),
                    Icon(Icons.shopping_cart, color: AppColors.success),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}