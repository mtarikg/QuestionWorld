import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/questionDetail.dart';
import 'mainPage.dart';

class AnswerQuestion extends StatefulWidget {
  @override
  _AnswerQuestionState createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
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
            content: Text("You have shared your answer successfully."),
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
      content: Text("Share your answer?"),
      actions: [noButton, yesButton],
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer the question"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FullPicture();
                    }));
                  },
                  child: Center(
                    child: Hero(
                      tag: 'imageHero',
                      child: Image.network(
                        'https://picsum.photos/250?image=9',
                      ),
                    ),
                  ),
                ),
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
                      "Add your answer",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
