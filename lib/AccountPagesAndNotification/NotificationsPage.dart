import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:question_world/Core/questionDetail.dart';
import 'package:question_world/models/user.dart';
import 'package:question_world/services/firestoreService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:indexed_list_view/indexed_list_view.dart';

class NotificationsPage extends StatefulWidget {
  final String profileOwnerID;

  NotificationsPage(this.profileOwnerID);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String answerUrl, questionUrl, TquestionUrl;
  var question, answer;
  var senderIDList = [];
  var questionsList =[];
  var answersList = [];
  var newQuestions = [];
  var newAnswers = [];
  var newIDS = [];
  var id;
  var notificationIndex;




    void checkNotifications() async {
      var Records = Firestore.instance.collection('notifications');
      await Records.snapshots().listen((notifications) {
        for (int i = 0; i < notifications.documents.length; i++) {
          if (widget.profileOwnerID ==
              notifications.documents[i].data['userID']) {
            setState(() {
              notificationIndex = notifications.documents[i].data['index'];
            });

            break;
          }
          if (i == notifications.documents.length - 1) {
            if (widget.profileOwnerID !=
                notifications.documents[i].data['userID']) {
              FirestoreService()
                  .createNotification(userID: widget.profileOwnerID);

              checkNotifications();
            }
          }
        }
      });
    }

    void updateIndex() async {
      setState(() {
        notificationIndex++;
      });
      var Records = Firestore.instance.collection('notifications');
      await Records.getDocuments().then((notification) {
        notification.documents.forEach((element) {
          if (element.data['userID'] == widget.profileOwnerID) {
            element.reference.updateData({'index': notificationIndex});
          }
        });
      });
    }

    var test1 = "0",
        test2 = "0",
        test3 = "0",
        test4 = "0",
        test5 = "0",
        test6 = "0",
        questionTest = "0",
        answerTest = "0",
        categorieTest = "0",
        QuestionTest = "0",
        AnswerTest = "0";

    void getQA() async {
      var Records = Firestore.instance.collection('categories');
      await Records.snapshots().listen((categories) {
        for (int i = 0; i < categories.documents.length; i++) {
          var questionCollection =
          categories.documents[i].reference.collection('questions');
          var questionsRecords =
          questionCollection.snapshots().forEach((questions) {
            for (int i = 0; i < questions.documents.length; i++) {
              if (widget.profileOwnerID ==
                  questions.documents[i].data['userID']) {
                setState(() {
                  question = questions.documents[i].data['imageURL'];
                });
                var answersCollection =
                questions.documents[i].reference.collection('answers');
                var answersRecords =
                answersCollection.snapshots().forEach((answers) {
                  for (int i = 0; i < answers.documents.length; i++) {
                    setState(() {
                      answer = answers.documents[i].data['imageURL'];
                      id = answers.documents[i].data['userID'];
                    });
                    setState(() {
                      questionsList.add(question);
                      answersList.add(answer);
                      senderIDList.add(id);
                    });
                  }
                });
              }
            }
          });
        }
      });
    }

    void removeOldList(int index) {
      newQuestions.removeAt(index);
      newAnswers.removeAt(index);
    }

    void initState() {
      getQA();
      checkNotifications();

      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Notifications"),
          ),
          body: FutureBuilder(
              future: FirestoreService().getUser(widget.profileOwnerID),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: ListView.builder(
                        itemCount: answersList.length,
                        itemBuilder: (context, int index) {

                          return Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width -
                                        25,
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height -
                                        500,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                          20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                            height: 180,
                                            width: 120,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Answer",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Container(
                                                      width: 150,
                                                      height: 150,
                                                      child: Image(
                                                          image: NetworkImage(
                                                              answersList[
                                                              index]))),
                                                  FutureBuilder(
                                                    future: FirestoreService()
                                                        .getUser(
                                                        senderIDList[
                                                        index]),
                                                    builder:
                                                        (context,
                                                        snapshot) {
                                                      if (!snapshot
                                                          .hasData) {
                                                        return Center(
                                                          child:
                                                          CircularProgressIndicator(),
                                                        );
                                                      } else {
                                                        return Info(
                                                            snapshot.data);
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            )),
                                        Container(
                                          child: Icon(
                                            Icons.arrow_forward_outlined,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 180,
                                          width: 120,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Question",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Container(
                                                  width: 150,
                                                  height: 150,
                                                  child: Image(
                                                      image: NetworkImage(
                                                          questionsList[
                                                          index]))),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        }),
                  );
                }
              }));
    }
  }

  Widget Info(User profileData) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(
                profileData.userName + " has answered the question",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ));
  }

