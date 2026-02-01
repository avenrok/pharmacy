import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/data/product_api.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _isFavorite = false;
  bool _isAddingToCart = false;

  final ProductApi _api = ProductApi();

  // Метод добавления товара в корзину
  Future<void> _addToCart() async {
    setState(() {
      _isAddingToCart = true;
    });

    try {
      await _api.addToCart(widget.product.id, quantity: 1);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Товар добавлен в корзину!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToCart = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    ImageProvider imageProvider;
    if (product.imageBase64 != null && product.imageBase64!.isNotEmpty) {
      try {
        imageProvider = MemoryImage(base64Decode(product.imageBase64!));
      } catch (_) {
        imageProvider = const AssetImage('lib/res/icons/tmc2.png');
      }
    } else {
      imageProvider = const AssetImage('lib/res/icons/tmc2.png');
    }

    String formatPrice(double price) =>
        price.toStringAsFixed(2).replaceAll('.', ',');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Страница товара'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image(
                  image: imageProvider,
                  width: 400,
                  height: 400,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Название товара
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                product.name,
                style: AppTextStyles.headline
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            // Цена и старая цена
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    formatPrice(product.price),
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    'lib/res/icons/valutRu.png',
                    width: 25,
                    height: 25,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 16),
                  if (product.oldPrice != null)
                    Text(
                      formatPrice(product.oldPrice!),
                      style: AppTextStyles.bodyText.copyWith(
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textHint,
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (product.discountPercentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product.discountPercentage}%',
                        style: AppTextStyles.bodyText
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Информация о рецепте
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppColors.textPrimary, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    'Товар отпускается по рецепту',
                    style: AppTextStyles.bodyText
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Описание товара
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Подробное описание товара, в котором говорится о назначении препарата, его побочных эффектах, а также то, в какой дозировке и когда его следует принимать.',
                style: AppTextStyles.bodyText,
              ),
            ),
            const SizedBox(height: 64),
            // Кнопка "Добавить в корзину" и избранное
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isAddingToCart ? null : _addToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isAddingToCart
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
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
                      });
                    },
                    child: Image.asset(
                      _isFavorite
                          ? 'lib/res/icons/favorites_add.png'
                          : 'lib/res/navigation_bar/image_favorites.png',
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
