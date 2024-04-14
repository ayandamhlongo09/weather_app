import 'package:flutter/material.dart';

import 'package:weather_app/pages/favorites.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/values/colors.dart';
import 'package:weather_app/values/icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  static List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      label: "Home",
      icon: AppIcons.home,
      activeIcon: AppIcons.home,
    ),
    const BottomNavigationBarItem(
      label: "Favorites",
      icon: AppIcons.favorites,
      activeIcon: AppIcons.favorites,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageList = [
      const HomePage(),
      const FavoritesPage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: pageList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
