import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/questionDetail.dart';
import 'package:question_world/services/firestoreService.dart';

class ShowQuestions extends StatefulWidget {
  final categoryName;

  ShowQuestions(this.categoryName);

  @override
  _ShowQuestionsState createState() => _ShowQuestionsState();
}

class _ShowQuestionsState extends State<ShowQuestions> {
  var questions = [];

  getQuestions() async {
    var questionsData =
        await FirestoreService().getCurrentQuestions(widget.categoryName);
    setState(() {
      questionsData.forEach((element) {
        questions.add(element);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Center(
        child: questions.length == 0
            ? Text("There is no question asked yet!")
            : ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          height: 310,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  height: 230,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Image.network(
                                    questions[index]["imageURL"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FutureBuilder(
                                      future: FirestoreService()
                                          .getUser(questions[index]["userID"]),
                                      builder: (context, snapshot) {
                                        if(!snapshot.hasData){
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        return Row(
                                          children: [
                                            CircleAvatar(
                                              child: Image(
                                                image: NetworkImage(
                                                    snapshot.data.photoUrl),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              snapshot.data.userName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: Text(
                                            questions[index]["description"])),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return QuestionDetail(
                                                questions[index]);
                                          }));
                                        },
                                        child: Text(
                                          "See answers!",
                                          style: TextStyle(color: Colors.blue),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
      ),
    );
  }
}
