import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/mainPage.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  String selectedCategory;
  final categories = [
    "Math",
    "Literature",
    "English",
    "Geography",
    "History",
    "Spanish",
  ];

  void changeCategory(newValue) {
    setState(() {
      selectedCategory = newValue;
    });
  }

  void alertUser() {
    Widget yesButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          Widget okButton = TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("OK"));

          var alert = AlertDialog(
            title: Text("Complete"),
            content: Text("You have shared your question successfully."),
            actions: [okButton],
          );

          showDialog(
              context: context, builder: (BuildContext context) => alert);
        },
        child: Text("Yes"));

    Widget noButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("No"));

    var alertDialog = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Share your question?"),
      actions: [noButton, yesButton],
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(75, 25, 75, 25),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                child: Icon(Icons.add, size: 100, color: Colors.white),
              ),
              SizedBox(height: 50),
              DropdownButton(
                hint: Text("Select a category"),
                value: selectedCategory,
                onChanged: changeCategory,
                items: categories.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add more information (optional)",
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    onPressed: alertUser,
                    child: Text(
                      "Add your question",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
