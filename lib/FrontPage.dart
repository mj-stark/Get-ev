import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'StorePage.dart';
import 'WishlistPage.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return StorePage();
      case 2:
        return WishlistPage();
      case 3:
        return ProfilePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( 
        body: _getPage(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.orange,
          fixedColor: Colors.purple,
          backgroundColor: Colors.purple,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
