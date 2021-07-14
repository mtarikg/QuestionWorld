import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/answerQuestion.dart';
import 'package:question_world/services/firestoreService.dart';

class QuestionDetail extends StatefulWidget {
  final question;

  QuestionDetail(this.question);

  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  var answers = [];

  getAnswers() async {
    var answersData =
        await FirestoreService().getCurrentAnswers(widget.question);
    setState(() {
      answersData.forEach((element) {
        answers.add(element);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAnswers();
  }

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: FutureBuilder(
                    future:
                        FirestoreService().getUser(widget.question["userID"]),
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          Image.network(
                            snapshot.data.photoUrl,
                            width: 35,
                            height: 35,
                          ),
                          SizedBox(width: 15),
                          Text(
                            snapshot.data.userName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            SizedBox(height: 20),
            widget.question["description"] == null
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      widget.question["description"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
            SizedBox(height: 20),
            widget.question["imageURL"] == null
                ? SizedBox()
                : Container(
                    child: InteractiveViewer(
                      child: Image.network(
                        widget.question["imageURL"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              AnswerQuestion(widget.question)),
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
            answers.length == 0
                ? Center(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Text(
                          "This question has no answer yet!",
                          style: TextStyle(fontSize: 15),
                        )),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: answers.length,
                    itemBuilder: (context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 8.0),
                                    child: FutureBuilder(
                                        future: FirestoreService()
                                            .getUser(answers[index]["userID"]),
                                        builder: (context, snapshot) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image(
                                                width: 35,
                                                height: 35,
                                                image: NetworkImage(
                                                    snapshot.data.photoUrl),
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                snapshot.data.userName,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      answers[index]["description"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: answers[index]["imageURL"] == null
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return FullPicture(
                                                    answers[index]["imageURL"]);
                                              }));
                                            },
                                            child: Center(
                                              child: Image.network(
                                                answers[index]["imageURL"],
                                                alignment: Alignment.centerLeft,
                                                width: 75,
                                                height: 75,
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
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
  final questionImage;

  FullPicture(this.questionImage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InteractiveViewer(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(questionImage, fit: BoxFit.fill),
          ),
        ),
      ),
    ));
  }
}
