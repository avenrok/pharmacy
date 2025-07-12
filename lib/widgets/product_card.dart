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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack( // Возвращаем Stack для звезды акции
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      "lib/res/icons/tmc.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    product.name,
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
                      // Показываем старую цену, только если она не пустая
                      if (product.oldPrice.isNotEmpty)
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
                      if (isInCart) 
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
                              // Здесь должна быть реальная логика получения количества
                              Text(' 999 ', style: AppTextStyles.bodyText.copyWith(color: AppColors.success)),
                              Icon(Icons.add, size: 16, color: AppColors.success),
                            ],
                          ),
                        )
                      else // Иначе показываем иконку корзины
                        Icon(Icons.shopping_cart, color: AppColors.success),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}