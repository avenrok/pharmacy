import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final List<FavoriteItem> _favoriteItems = [
    FavoriteItem(
      product: Product(
          id: 1, name: 'Название товара', price: 999.99, oldPrice: 1299.99),
      quantity: 1,
      requiresPrescription: false,
    ),
    FavoriteItem(
      product: Product(
          id: 2, name: 'Название товара', price: 999.99, oldPrice: 1299.99),
      quantity: 1,
      requiresPrescription: true,
    ),
  ];

  void _updateQuantity(int index, int delta) {
    setState(() {
      int newQuantity = _favoriteItems[index].quantity + delta;
      if (newQuantity > 0) {
        _favoriteItems[index].quantity = newQuantity;
      } else {
        _favoriteItems.removeAt(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() => _favoriteItems.removeAt(index));
  }

  void _addToCart(FavoriteItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Товар "${item.product.name}" добавлен в корзину.')),
    );
  }

  String formatPrice(double price) =>
      price.toStringAsFixed(2).replaceAll('.', ',');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _favoriteItems.length,
            itemBuilder: (context, index) {
              final item = _favoriteItems[index];

              ImageProvider imageProvider =
                  const AssetImage('lib/res/icons/tmc.png');
              if (item.product.imageBase64 != null &&
                  item.product.imageBase64!.isNotEmpty) {
                try {
                  imageProvider =
                      MemoryImage(base64Decode(item.product.imageBase64!));
                } catch (_) {}
              }

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
                      GestureDetector(
                        onTap: () => _removeItem(index),
                        child: Image.asset(
                          'lib/res/icons/favorites_add.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.success),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image(image: imageProvider),
                      ),
                      const SizedBox(width: 16),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
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
                                  formatPrice(item.product.price),
                                  style: AppTextStyles.bodyText
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (item.requiresPrescription)
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
                                  style: AppTextStyles.bodyText
                                      .copyWith(color: Colors.white),
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
