import 'package:flutter/material.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';

class CartActionBar extends StatelessWidget {
  final bool selectAll;
  final ValueChanged<bool?> onSelectAllChanged;
  final VoidCallback onDeleteSelected;

  const CartActionBar({
    super.key,
    required this.selectAll,
    required this.onSelectAllChanged,
    required this.onDeleteSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: selectAll,
                onChanged: onSelectAllChanged,
                activeColor: AppColors.success,
              ),
              Text('Выбрать все', style: AppTextStyles.bodyText),
            ],
          ),
          TextButton.icon(
            onPressed: onDeleteSelected,
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            label: Text('Удалить выбранные',
                style: AppTextStyles.bodyText.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
