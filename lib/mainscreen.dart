import 'package:flutter/material.dart';
import 'home.dart';
import 'draft.dart';
import 'Profile.dart';

class mainscreen extends StatefulWidget {
  const mainscreen({Key? key}) : super(key: key);
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = [home(), draft(), Profile()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_sharp),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff7d0893),
        onTap: _onItemTapped,
      ),
    );
  }
}
