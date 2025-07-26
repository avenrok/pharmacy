import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/bottom_nav_bar.dart';
import 'package:pharmacy/view/search/search_page.dart';
import 'package:pharmacy/view/profile/profile_page.dart';
import 'package:pharmacy/view/basket/basket_page.dart';
import 'package:pharmacy/view/favorites/favorites.dart';
import 'package:pharmacy/view/catalog/categories.dart';
import 'package:pharmacy/theme/app_colors.dart';
import 'package:pharmacy/res/styles/styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Индекс для нижней навигации

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _appBarSearchFocusNode = FocusNode();

  final List<String> _recentSearches = const [
    'Недавний поиск 1',
    'Недавний поиск 2',
    'Недавний поиск 3',
  ];

  late final List<Widget> _screenBodies;

  @override
  void initState() {
    super.initState();
    _appBarSearchFocusNode.addListener(_onSearchFocusChanged);

    _screenBodies = <Widget>[
      Search(
        focusNode: _appBarSearchFocusNode,
        recentSearches: _recentSearches,
      ),
      const Categories(),
      const BasketPage(),
      const Favorites(),
      const Profile(),
    ];
  }

  void _onSearchFocusChanged() {
    setState(() {
      // Это вызовет перестроение _screenBodies[0] (SearchPageContent)
      // и он сможет условно показать "Недавние поиски"
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _searchController.clear();
    _appBarSearchFocusNode.unfocus(); // Сбрасываем фокус при смене вкладки
  }

  @override
  void dispose() {
    _searchController.dispose();
    _appBarSearchFocusNode.removeListener(_onSearchFocusChanged);
    _appBarSearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _screenBodies.elementAt(_selectedIndex),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    // AppBar с полем поиска для Главной страницы (индекс 0) и Каталога (индекс 1)
    if (_selectedIndex == 0 || _selectedIndex == 1) {
      return AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _appBarSearchFocusNode,
              decoration: const InputDecoration(
                hintText: 'Начните вводить название товара',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              ),
              onSubmitted: (query) {
                _appBarSearchFocusNode.unfocus(); // Скрыть недавние поиски после отправки
              },
            ),
          ),
        ),
      );
    }
    // AppBar для Корзины (индекс 2)
    else if (_selectedIndex == 2) {
      return AppBar(
        backgroundColor: Colors.white,
        title: const Text('Корзина'),
        centerTitle: true,
      );
    }
    // AppBar для Избранного (индекс 3)
    else if (_selectedIndex == 3) {
      return AppBar(
        backgroundColor: Colors.white,
        title: const Text('Избранное'),
        centerTitle: true,
      );
    }
    // AppBar для Профиля (индекс 4)
    else if (_selectedIndex == 4) {
      return AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0, // Убираем дефолтный отступ
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0), 
          child: Row(
            children: [
              CircleAvatar(
                  radius: 30, 
                  backgroundColor: Colors.transparent, 
                  child: ClipOval(
                    child: Image.asset(
                      "lib/res/icons/avatar.png", 
                      width: 30, 
                      height: 30, 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Фамилия Имя',
                  style: AppTextStyles.headline.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 8.0), 
        ],
        centerTitle: false,
      );
    }
    return AppBar(title: const Text('...'), centerTitle: true);
  }
}