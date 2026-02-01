import 'package:flutter/material.dart';
import 'package:pharmacy/data/app_config.dart';
import 'package:pharmacy/data/product_api.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/widgets/recent_serches.dart';
import 'package:pharmacy/widgets/product_section.dart';
import 'package:pharmacy/view/search/search_state.dart';

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
  // ⚠️ Здесь была ошибка: Product вместо ProductApi
  final _api = ProductApi(baseUrl: AppConfig.apiBaseUrl);

  bool _isSearchFocused = false;

  late Loadable<List<Product>> _action;
  late Loadable<List<Product>> _weekly;
  late Loadable<List<Product>> _hurry;

  @override
  void initState() {
    super.initState();

    _action = Loadable.initial(const []);
    _weekly = Loadable.initial(const []);
    _hurry = Loadable.initial(const []);

    widget.focusNode.addListener(_handleFocusChange);

    _loadProducts(
      fetcher: _api.fetchActionProducts,
      onUpdate: (state) => setState(() => _action = state),
    );
    _loadProducts(
      fetcher: _api.fetchWeeklyProducts,
      onUpdate: (state) => setState(() => _weekly = state),
    );
    _loadProducts(
      fetcher: _api.fetchHurryToBuyProducts,
      onUpdate: (state) => setState(() => _hurry = state),
    );
  }

  void _handleFocusChange() {
    setState(() {
      _isSearchFocused = widget.focusNode.hasFocus;
    });
  }

  Future<void> _loadProducts({
    required Future<List<Product>> Function() fetcher,
    required void Function(Loadable<List<Product>>) onUpdate,
  }) async {
    onUpdate(Loadable(isLoading: true, data: const []));

    try {
      final products = await fetcher();
      onUpdate(Loadable(isLoading: false, data: products));
    } catch (e) {
      onUpdate(
        Loadable(isLoading: false, data: const [], error: e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isSearchFocused && widget.recentSearches.isNotEmpty)
            RecentSearches(
              items: widget.recentSearches,
              onItemTap: widget.focusNode.unfocus,
            ),
          if (!_isSearchFocused) ...[
            const SizedBox(height: 16),
            ProductSection(title: 'Акционный товар', state: _action),
            ProductSection(title: 'Товары недели', state: _weekly),
            ProductSection(title: 'Успей купить!', state: _hurry),
          ],
        ],
      ),
    );
  }
}
