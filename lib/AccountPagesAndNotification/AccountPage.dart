import 'package:flutter/material.dart';
import 'package:question_world/Core/questionDetail.dart';
import 'package:question_world/models/user.dart';
import 'package:question_world/services/firestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  final String profileOwnerId;

  const AccountPage({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var question;
  var questionsList = new List();
  var description;
  var descriptionList = [];
  var questionObj;
  var questionObjList = new List();

  void getQuestions() async {
    var Records = Firestore.instance.collection('categories');
    await Records.snapshots().listen((categories) {
      for (int i = 0; i < categories.documents.length; i++) {
        var questionCollection =
            categories.documents[i].reference.collection('questions');
        var questionsRecords =
            questionCollection.snapshots().forEach((questions) {
          for (int i = 0; i < questions.documents.length; i++) {
            if (widget.profileOwnerId ==
                questions.documents[i].data['userID']) {
              setState(() {
                question = questions.documents[i].data['imageURL'];
                description = questions.documents[i].data['description'];
                questionObj = questions.documents[i];
              });
              setState(() {
                questionsList.add(question);
                descriptionList.add(description);
                questionObjList.add(questionObj);
              });
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Object>(
          future: FirestoreService().getUser(widget.profileOwnerId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return _pageWidgets(snapshot.data, context);
          }),
    );
  }

  Widget _pageWidgets(User profilData, BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 60,
              backgroundImage: profilData.photoUrl.isNotEmpty
                  ? NetworkImage(profilData.photoUrl)
                  : AssetImage("assets/images/user.jpg"),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.grey),
                      bottom: BorderSide(width: 1, color: Colors.grey))),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                  child: Text(
                profilData.userName,
                style: TextStyle(fontSize: 20, color: Colors.black87),
              )),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                  child: Text(
                profilData.school,
                style: TextStyle(fontSize: 20, color: Colors.black87),
              )),
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Center(
                child: Text(
              profilData.instagram,
              style: TextStyle(fontSize: 20, color: Colors.black87),
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
              child: Text(
            "My Questions",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 30,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.builder(
                itemCount: questionsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: questionsList[index] == null
                            ? SizedBox()
                            : Container(
                                width: MediaQuery.of(context).size.width - 60,
                                height: 230,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Image.network(
                                  questionsList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Image(
                                      image: NetworkImage(profilData.photoUrl),
                                    ),
                                  ),
                                  Text(
                                    profilData.userName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: description == null
                                  ? SizedBox()
                                  : Text(descriptionList[index]),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return QuestionDetail(
                                        questionObjList[index]);
                                  }));
                                },
                                child: Text(
                                  "See answers!",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }
}
