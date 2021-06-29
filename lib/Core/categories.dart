import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:question_world/Core/showQuestions.dart';
import 'package:question_world/services/authorizationService.dart';

class Categories extends StatelessWidget {
  final categories = [
    "Math",
    "Literature",
    "English",
    "Geography",
    "History",
    "Spanish",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ShowQuestions(categories[index]);
                      }));
                    },
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
