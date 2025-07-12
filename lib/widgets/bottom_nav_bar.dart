import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/res/navigation_bar/image_main.svg',
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_main_active.svg",
            width: 25,
            height: 25,
          ),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon:  Image.asset(
            'lib/res/navigation_bar/image_catalog.svg',
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_catalog_active.svg",
            width: 25,
            height: 25,
          ),
          label: 'Каталог',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/res/navigation_bar/image_basket.svg",
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_basket_active.svg",
            width: 25,
            height: 25,
          ),
          label: 'Корзина',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/res/navigation_bar/image_favorites.svg",
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_favorite_active.svg",
            width: 25,
            height: 25,
          ),
          label: 'Избранное',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "lib/res/navigation_bar/image_profile.svg",
            width: 25,
            height: 25,
          ),
          activeIcon: Image.asset(
            "lib/res/navigation_bar/image_favorite_active.svg",
            width: 25,
            height: 25,
          ),
          label: 'Профиль',
        ),
      ],
    );
  }
}