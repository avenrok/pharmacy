import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/bottom_nav_bar.dart';
import 'package:pharmacy/view/search/search_page.dart'; 
import 'package:pharmacy/view/profile/profile_page_content.dart';
import 'package:pharmacy/view/basket/basket_page.dart';
import 'package:pharmacy/view/favorites/favorites.dart';
import 'package:pharmacy/view/catalog/categories.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Индекс для нижней навигации

  final TextEditingController _searchController = TextEditingController();

  static final List<Widget> _screenBodies = <Widget>[
    const Search(), 
    const Categories(), 
    const BasketPage(),
    const Favorites(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _searchController.clear();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context), // Динамический AppBar
      body: _screenBodies.elementAt(_selectedIndex), // Отображаем выбранное тело экрана
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    if (_selectedIndex == 2) { 
      return AppBar(
        title: const Text('Корзина'),
        centerTitle: true,
      );
    } else if (_selectedIndex == 3) { 
      return AppBar(
        title: const Text('Избранное'),
        centerTitle: true,
      );
    } else if (_selectedIndex == 4) { 
      return AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      );
    } else { // Для Главной страницы (Поиска) и Каталога
      return AppBar(
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
                // print('Глобальный поиск по запросу: $query');
              },
            ),
          ),
        ),
      );
    }
  }
}

// class Categories extends StatelessWidget {
//   const Categories({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Row(
//             children: [
//               Icon(Icons.add_box_outlined, color: Colors.green, size: 30),
//               const SizedBox(width: 16.0),
//               Text(
//                 'Категория ${index + 1}',
//                 style: const TextStyle(fontSize: 18),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }