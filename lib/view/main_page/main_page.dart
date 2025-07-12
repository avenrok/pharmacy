import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/bottom_nav_bar.dart';
// import 'package:pharmacy/widgets/product_card.dart'; // ProductCard не используется напрямую здесь
import 'package:pharmacy/view/search/search_page.dart'; // Импортируем SearchPageContent

// Убедитесь, что CategoriesScreenContent (если он в отдельном файле) импортирован.
// Если он определен в этом же файле, как в вашем примере, импорт не нужен.
// import 'package:pharmacy/view/categories/categories_screen_content.dart'; // Пример импорта

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Индекс для нижней навигации

  // ОБЪЯВЛЯЕМ TextEditingController ЗДЕСЬ
  final TextEditingController _searchController = TextEditingController();

  // 1. Убедитесь, что этот список _screenBodies содержит ТОЧНО столько же элементов,
  // сколько у вас в BottomNavigationBarItem в CustomBottomNavBar (обычно 5).
  static final List<Widget> _screenBodies = <Widget>[
    const SearchPageContent(), // Индекс 0: Главная страница с контентом поиска
    const CategoriesScreenContent(), // Индекс 1: Страница Каталога (раскомментировано и используется)
    const Center(child: Text('Корзина')), // Индекс 2: Страница Корзины
    const Center(child: Text('Избранное')), // Индекс 3: Страница Избранного
    const Center(child: Text('Профиль')), // Индекс 4: Страница Профиля
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Очищаем поле поиска при смене вкладки, если это глобальный поиск
    _searchController.clear();
  }

  @override
  void dispose() {
    // Важно: освобождаем ресурсы контроллера при удалении виджета
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              decoration: const InputDecoration(
                hintText: 'Начните вводить название товара',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              ),
              onSubmitted: (query) {
                // Логика поиска, которая может зависеть от текущей вкладки
                print('Глобальный поиск по запросу: $query');
                // как именно будет происходить поиск:
                // - Передача запроса в SearchPageContent
                // - Переход на отдельный экран результатов поиска
                // - Обновление данных через стейт-менеджмент
              },
            ),
          ),
        ),
        // Если хотите добавить другие действия справа от поиска, например, корзину
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart), // Используйте const, если возможно
            onPressed: () {
              // Перейти на страницу корзины
            },
          ),
        ],
      ),
      body: _screenBodies.elementAt(_selectedIndex), // Отображаем выбранное тело экрана
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class CategoriesScreenContent extends StatelessWidget {
  const CategoriesScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.add_box_outlined, color: Colors.green, size: 30),
              const SizedBox(width: 16.0),
              Text(
                'Категория ${index + 1}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}