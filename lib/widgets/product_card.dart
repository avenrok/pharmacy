import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/widgets/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isInCart;

  const ProductCard({super.key, required this.product, this.isInCart = false, required });

  @override
  Widget build(BuildContext context) {
    final priceFormatter = NumberFormat.currency(locale: 'ru_RU', symbol: '₽', decimalDigits: 0);

    Widget productImage() {
      if (product.imageBase64 != null && product.imageBase64!.isNotEmpty) {
        try {
          final bytes = base64Decode(product.imageBase64!);
          return Image.memory(bytes, width: 150, height: 150, fit: BoxFit.contain);
        } catch (_) {}
      }
      return Image.asset('lib/res/icons/tmc.png', width: 150, height: 150);
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailsPage(product: product)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Center(child: productImage()),
                    if (product.isActionProduct)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: const Text('Акция', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(product.name, textAlign: TextAlign.center, style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(priceFormatter.format(product.price), style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold, color: AppColors.error)),
                  if (product.oldPrice != null) const SizedBox(width: 8),
                  if (product.oldPrice != null)
                    Text(priceFormatter.format(product.oldPrice!), style: AppTextStyles.caption.copyWith(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              if (isInCart) Align(alignment: Alignment.center, child: Icon(Icons.shopping_cart, color: AppColors.textPrimary, size: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
