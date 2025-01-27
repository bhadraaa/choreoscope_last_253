import '../../../../screen/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../../../screen/profile.dart';
import '../../../../screen/search.dart';
//import 'home.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _page = 0; // Default to the Home page
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // List of pages for the bottom navigation bar
  final List<Widget> _pages = [
    MySearch(),
    MyHome(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 100, 12, 5),
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index; // Update the index to switch the content
          });
        },
      ),
      body: _pages[_page], // Display the selected page
    );
  }
}
