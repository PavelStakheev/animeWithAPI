import 'package:flutter/material.dart';
import 'package:jikan_api2/features/Explorer/view/explorer_screen.dart';
import 'package:jikan_api2/features/Favorite/favorites_screen.dart';
import 'package:jikan_api2/features/anime_list/view/anime_list_screen.dart';
import 'package:jikan_api2/theme/theme.dart';

class MyNavBarScreen extends StatefulWidget {
  const MyNavBarScreen({super.key});

  @override
  State<MyNavBarScreen> createState() => _MyNavBarScreenState();
}

class _MyNavBarScreenState extends State<MyNavBarScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const AnimeListScreen(),
    const MyExplorerScreen(),
    const MyFavoriteScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: darkTheme.primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
