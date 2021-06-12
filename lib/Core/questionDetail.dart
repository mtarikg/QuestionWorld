import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/answerQuestion.dart';

class QuestionDetail extends StatelessWidget {
  final answers = ["a1", "a2", "a3", "a4", "a5"];
  final question;

  QuestionDetail(this.question);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(
                    Icons.person, // will be the profile pic of a user
                    color: Colors.black,
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      "Username here",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Question title here",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AnswerQuestion()),
                    );
                  },
                  child: Text(
                    "Answer this question!",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Answers",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: answers.length,
                itemBuilder: (context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlueAccent,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black87,
                                ),
                                // will be the profile pic of a user
                                SizedBox(width: 15),
                                Text(
                                  "Username here",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Answer here",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return FullPicture();
                                  }));
                                },
                                child: Center(
                                  child: Hero(
                                    tag: 'imageHero',
                                    child: Image.network(
                                      'https://picsum.photos/250?image=9',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class FullPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
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
    );
  }
}
