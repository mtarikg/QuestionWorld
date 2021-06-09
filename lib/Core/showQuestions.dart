import 'package:flutter/material.dart';

class ShowQuestions extends StatelessWidget {
  final categoryName;

  ShowQuestions(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text("You are in " + categoryName + " page!"),
      ),
    );
  }
}
