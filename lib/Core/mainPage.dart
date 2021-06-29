import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_world/AccountPagesAndNotification/AccountPage.dart';
import 'package:question_world/AccountPagesAndNotification/NotificationsPage.dart';
import 'package:question_world/AccountPagesAndNotification/PolicyPage.dart';
import 'package:question_world/AccountPagesAndNotification/SettingsPage.dart';
import 'package:question_world/Core/addQuestion.dart';
import 'package:question_world/services/authorizationService.dart';
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
    AccountPage()

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
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsPage()));
              }),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              icon: Icon(Icons.more_horiz))
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
