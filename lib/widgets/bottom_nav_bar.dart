import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/res/navigation_bar/image_main.png',
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_main_active.png",
            width: 25,
            height: 25,
          ),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon:  Image.asset(
            'lib/res/navigation_bar/image_catalog.png',
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_catalog_active.png",
            width: 25,
            height: 25,
          ),
          label: 'Каталог',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/res/navigation_bar/image_basket.png",
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_basket_active.png",
            width: 25,
            height: 25,
          ),
          label: 'Корзина',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/res/navigation_bar/image_favorites.png",
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_favorite_active.png",
            width: 25,
            height: 25,
          ),
          label: 'Избранное',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/res/navigation_bar/image_profile.png",
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_favorite_active.png",
            width: 25,
            height: 25,
          ),
          label: 'Профиль',
        ),
      ],
    );
  }
}