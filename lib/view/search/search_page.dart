import 'package:flutter/material.dart';
import 'package:pharmacy/data/product_api.dart';
import 'package:pharmacy/widgets/product_card.dart';
import 'package:pharmacy/res/styles/styles.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/models/product.dart';

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

  final ProductApi _api = ProductApi(
    baseUrl: 'https://your-api.com',
  );

  List<Product> _actionProducts = const [];
  bool _isLoadingActionProducts = false;
  String? _errorActionProducts;

  List<Product> _weeklyProducts = const [];
  bool _isLoadingWeeklyProducts = false;
  String? _errorWeeklyProducts;

  List<Product> _hurryToBuyProducts = const [];
  bool _isLoadingHurryToBuyProducts = false;
  String? _errorHurryToBuyProducts;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
    // Вызываем загрузку товаров
    _loadActionProducts();
    _loadWeeklyProducts();
    _loadHurryToBuyProducts();
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

  Future<void> _loadActionProducts() async {
    setState(() {
      _isLoadingActionProducts = true;
      _errorActionProducts = null;
    });

    try {
      final products = await _api.fetchActionProducts();
      setState(() {
        _actionProducts = products;
      });
    } catch (e) {
      setState(() {
        _errorActionProducts = e.toString();
      });
    } finally {
      setState(() {
        _isLoadingActionProducts = false;
      });
    }
  }

  Future<void> _loadWeeklyProducts() async {
    setState(() {
      _isLoadingWeeklyProducts = true;
      _errorWeeklyProducts = null;
    });

    try {
      final products = await _api.fetchWeeklyProducts();
      setState(() {
        _weeklyProducts = products;
      });
    } catch (e) {
      setState(() {
        _errorWeeklyProducts = e.toString();
      });
    } finally {
      setState(() {
        _isLoadingWeeklyProducts = false;
      });
    }
  }

  Future<void> _loadHurryToBuyProducts() async {
    setState(() {
      _isLoadingHurryToBuyProducts = true;
      _errorHurryToBuyProducts = null;
    });

    try {
      final products = await _api.fetchHurryToBuyProducts();
      setState(() {
        _hurryToBuyProducts = products;
      });
    } catch (e) {
      setState(() {
        _errorHurryToBuyProducts = e.toString();
      });
    } finally {
      setState(() {
        _isLoadingHurryToBuyProducts = false;
      });
    }
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
            if (_isLoadingActionProducts ||
                _isLoadingWeeklyProducts ||
                _isLoadingHurryToBuyProducts)
              const Center(child: CircularProgressIndicator())
            else if (_errorActionProducts != null)
              Text(_errorActionProducts!,
                  style: const TextStyle(color: Colors.red))
            else if (_errorWeeklyProducts != null)
              Text(_errorWeeklyProducts!,
                  style: const TextStyle(color: Colors.red))
            else if (_errorHurryToBuyProducts != null)
              Text(_errorHurryToBuyProducts!,
                  style: const TextStyle(color: Colors.red))
            else
              _buildProductSection(
                  title: 'Акционный товар', products: _actionProducts),
            _buildProductSection(
                title: 'Товары недели', products: _weeklyProducts),
            _buildProductSection(
                title: 'Успей купить!', products: _hurryToBuyProducts),
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
                  widget.focusNode
                      .unfocus(); // Закрываем недавние поиски после выбора
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
              style: AppTextStyles.headline.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.error),
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
