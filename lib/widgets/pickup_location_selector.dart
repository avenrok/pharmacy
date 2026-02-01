import 'package:flutter/material.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';

class PickupLocationSelector extends StatelessWidget {
  final String? selectedLocation;
  final VoidCallback? onTap;

  const PickupLocationSelector({
    super.key,
    this.selectedLocation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Укажите пункт выдачи заказа',
            style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textHint.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLocation ?? 'Выбрать пункт выдачи...',
                    style: AppTextStyles.bodyText
                        .copyWith(color: AppColors.textHint),
                  ),
                  const Icon(Icons.location_on, color: AppColors.textHint),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
