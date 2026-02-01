import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacy/models/cart_item.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final ValueChanged<bool?>? onSelected;
  final void Function(int delta)? onQuantityChanged;

  const CartItemTile({
    super.key,
    required this.item,
    this.onSelected,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider =
        const AssetImage('lib/res/icons/tmc.png');
    if (item.product.imageBase64 != null &&
        item.product.imageBase64!.isNotEmpty) {
      try {
        imageProvider = MemoryImage(base64Decode(item.product.imageBase64!));
      } catch (_) {}
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: item.isSelected,
            onChanged: onSelected,
            activeColor: AppColors.success,
          ),
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
                  style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
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
                        border: Border.all(color: AppColors.success),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onQuantityChanged?.call(-1),
                            child: Icon(Icons.remove, size: 16, color: AppColors.success),
                          ),
                          Text(' ${item.quantity} ',
                              style: AppTextStyles.bodyText.copyWith(color: AppColors.success)),
                          GestureDetector(
                            onTap: () => onQuantityChanged?.call(1),
                            child: Icon(Icons.add, size: 16, color: AppColors.success),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${item.product.price.toStringAsFixed(2).replaceAll('.', ',')} ₽',
                      style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (item.requiresPrescription)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: AppColors.warning, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Товар отпускается по рецепту',
                          style: AppTextStyles.hintText.copyWith(color: AppColors.warning),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
