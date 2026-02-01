import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/view/search/search_state.dart';
import 'package:pharmacy/widgets/product_card.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final Loadable<List<Product>> state;

  const ProductSection({
    super.key,
    required this.title,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          state.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (state.data.isEmpty) {
      return const SizedBox.shrink();
    }

    return _SectionContainer(
      title: title,
      child: _ProductGrid(products: state.data),
    );
  }
}

/* -------------------- UI -------------------- */

class _SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionContainer({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.headline.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> products;

  const _ProductGrid({
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (_, index) {
        return ProductCard(
          product: products[index],
          isInCart: false,
        );
      },
    );
  }
}
