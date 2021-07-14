import 'package:flutter/material.dart';
import 'package:question_world/AccountPagesAndNotification/AccountPage.dart';
import 'package:question_world/AccountPagesAndNotification/PolicyPage.dart';
import 'package:question_world/AccountPagesAndNotification/ProfileUpdatePage.dart';
import 'package:question_world/Auth/loginPage.dart';
import 'package:question_world/services/authorizationService.dart';

import 'NotificationsPage.dart';

class SettingsPage extends StatefulWidget {
  final String profileOwnerId;

  const SettingsPage({Key key,this.profileOwnerId}): super(key:key);
  @override

  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.body1,
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.settings,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextSpan(
                    text: "Settings",
                    style: TextStyle(fontSize: 50, color: Colors.blue)),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
          ),
          Card(
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileUpdatePage(
                              profileOwnerId: widget.profileOwnerId,
                            )));
                  },
                  child: Text("Update Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Card(
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PolicyPage()));
                  },
                  child: Text("Policy Page",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Card(
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                  onPressed: () {
                    AuthorizationService().logOut();
                    Navigator.pop(context);
                  },
                  child: Text("Log Out",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
        ],
      )),
    );
  }
}
