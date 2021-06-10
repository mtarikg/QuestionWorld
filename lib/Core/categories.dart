import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:question_world/Core/showQuestions.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 150,
                          height: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ShowQuestions(categories[index]);
                              }));
                            },
                            child: Text(categories[index]),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
