import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_world/direct.dart';
import 'package:question_world/services/authorizationService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthorizationService>(
      create: (_) => AuthorizationService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Direct(),
      ),
    );
  }
}
