import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<BottomNavigationBarItem> _bottomNavbarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_gymnastics),
        label: 'BMI',
        backgroundColor: Colors.red),
    BottomNavigationBarItem(
        icon: Icon(Icons.add), label: 'Home', backgroundColor: Colors.red)
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: const Text(
          'T M W',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        elevation: 10.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavbarItems,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Colors.red[700],
      ),
    );
  }
}
