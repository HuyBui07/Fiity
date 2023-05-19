import 'package:flutter/material.dart';
import 'package:fitty/homeScreen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitty/loginScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
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
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Search',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print('Sign out');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const LoginScreen())));
              });
            },
            child: Text('Logout')),
      ),
    );
  }
}
