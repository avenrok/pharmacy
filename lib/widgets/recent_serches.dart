import 'package:flutter/material.dart';
import 'package:pharmacy/res/styles/styles.dart';

class RecentSearches extends StatelessWidget {
  final List<String> items;
  final VoidCallback onItemTap;

  const RecentSearches({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Недавние поиски',
            style: AppTextStyles.bodyText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: onItemTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(items[index]),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
