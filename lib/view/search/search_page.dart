import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/product_card.dart'; 
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';

class Search extends StatefulWidget {
  final FocusNode focusNode;
  final List<String> recentSearches; 

  const Search({
    super.key,
    required this.focusNode, 
    required this.recentSearches,
    });


 @override
 State<Search> createState() => _SearchState();
}


class _SearchState extends State<Search> {

  bool _isSearchFocused = false;

 final List<Product> _actionProducts = const [
  Product(name: 'Название товара', price: '999,99 ₽', oldPrice: '1 299,99 ₽', discountPercentage: 25, isActionProduct: true),
  Product(name: 'Название товара', price: '750,00 ₽', oldPrice: '900,00 ₽', discountPercentage: 15, isActionProduct: true),
 ];


 final List<Product> _weeklyProducts = const [
  Product(name: 'Название товара', price: '800,00 ₽', oldPrice: '950,00 ₽'),
  Product(name: 'Название товара', price: '600,00 ₽', oldPrice: '700,00 ₽'),
 ];


 final List<Product> _hurryToBuyProducts = const [
  Product(name: 'Название товара', price: '450,00 ₽', oldPrice: '500,00 ₽', discountPercentage: 10),
  Product(name: 'Название товара', price: '300,00 ₽', oldPrice: '350,00 ₽'),
 ];

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isSearchFocused = widget.focusNode.hasFocus;
    });
  }

   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isSearchFocused && widget.recentSearches.isNotEmpty)
            _buildRecentSearches(),

          if (!_isSearchFocused) ...[
            const SizedBox(height: 16.0),
            _buildProductSection(title: 'Акционный товар', products: _actionProducts),
            _buildProductSection(title: 'Товары недели', products: _weeklyProducts),
            _buildProductSection(title: 'Успей купить!', products: _hurryToBuyProducts),
            const SizedBox(height: 16.0),
          ],
        ],
      ),
    );
  }

Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Недавние поиски:',
            style: AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.recentSearches.length,
            itemBuilder: (context, index) {
              final search = widget.recentSearches[index];
              return InkWell(
                onTap: () {
                  widget.focusNode.unfocus(); // Закрываем недавние поиски после выбора
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(search),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }


 Widget _buildProductSection({
    required String title,
    required List<Product> products,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.headline.copyWith(fontWeight: FontWeight.bold, color: AppColors.error),
            ),
            const SizedBox(height: 12.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.elementAt(index);
                return ProductCard(product: product, isInCart: false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String price;
  final String oldPrice;
  final bool isNew;
  final bool requiresPrescription;
  final int? discountPercentage; 
  final bool isActionProduct; 

  const Product({ 
    required this.name,
    required this.price,
    this.oldPrice = '',
    this.isNew = false,
    this.requiresPrescription = false,
    this.discountPercentage, 
    this.isActionProduct = false, 
  });
}