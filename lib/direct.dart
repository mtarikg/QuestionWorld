import 'package:flutter/material.dart';
import 'package:question_world/Core/categories.dart';
import 'package:question_world/models/user.dart';
import 'package:question_world/services/authorizationService.dart';
import 'package:question_world/welcomePage.dart';

class Direct extends StatelessWidget {
  const Direct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthorizationService().statusTracker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            User _activeUser = snapshot.data;
            return Categories();
          } else {
            return WelcomePage();
          }
        });
  }
}
