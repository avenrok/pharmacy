import 'package:flutter/material.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';

class BasketBottomBar extends StatelessWidget {
  final String totalPrice;
  final VoidCallback onCheckout;

  const BasketBottomBar({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Оформить заказ',
                  style: AppTextStyles.buttonTextStyle,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              totalPrice,
              style: AppTextStyles.headline.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
