import 'package:fitty/mainScreen/homeScreen.dart';
import 'package:fitty/mainScreen/searchScreen.dart';
import 'package:fitty/user/userPage.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    SearchForExercises(),
    UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
