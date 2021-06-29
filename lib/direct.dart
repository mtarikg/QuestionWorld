import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_world/Core/mainPage.dart';
import 'package:question_world/models/user.dart';
import 'package:question_world/services/authorizationService.dart';
import 'package:question_world/welcomePage.dart';

class Direct extends StatelessWidget {
  const Direct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService =
        Provider.of<AuthorizationService>(context, listen: false);
    return StreamBuilder(
        stream: _authService.statusTracker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            User _activeUser = snapshot.data;
            _authService.activeUserId = _activeUser.id;
            return MainPage();
          } else {
            return WelcomePage();
          }
        });
  }
}
