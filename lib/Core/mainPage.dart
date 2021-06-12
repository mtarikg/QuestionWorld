import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/addQuestion.dart';
import 'categories.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _barIndex = 0;
  final _pages = <Widget>[
    Categories(),
    AddQuestion(),
    // Profile(),
  ];

  void _onTapped(int index) {
    setState(() {
      _barIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question World"),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      body: Center(
        child: _pages.elementAt(_barIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _barIndex,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }
}
