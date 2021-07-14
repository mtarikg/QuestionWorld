import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:question_world/services/authorizationService.dart';
import 'package:question_world/services/firestoreService.dart';
import 'package:question_world/services/storageService.dart';
import 'mainPage.dart';

class AnswerQuestion extends StatefulWidget {
  final question;

  AnswerQuestion(this.question);

  @override
  _AnswerQuestionState createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  bool imageLoaded = false;
  File file;

  TextEditingController descriptionController = TextEditingController();

  selectPhoto() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                child: Text("Camera"),
                onPressed: () {
                  camera();
                },
              ),
              SimpleDialogOption(
                child: Text("Gallery"),
                onPressed: () {
                  gallery();
                },
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  camera() async {
    Navigator.pop(context);
    var image = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      file = File(image.path);
      imageLoaded = true;
    });
  }

  gallery() async {
    Navigator.pop(context);
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      file = File(image.path);
      imageLoaded = true;
    });
  }

  Future<void> uploadAnswer() async {
    var alert = AlertDialog(
        title: Column(
          children: [
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
            SizedBox(height: 10),
            Text("Please wait...")
          ],
        ),
        content: Text("Uploading...", textAlign: TextAlign.center));

    showDialog(context: context, builder: (BuildContext context) => alert);

    String qImageURL = await StorageService().uploadImage(file);
    String activeUserID =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;

    await FirestoreService().createNewAnswer(
        question: widget.question,
        imageURL: qImageURL,
        description: descriptionController.text,
        userID: activeUserID);

    setState(() {
      descriptionController.clear();
      file = null;
    });
  }

  void alertUser() {
    Widget yesButton = TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          await uploadAnswer();
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
              (!imageLoaded
                  ? imagePicker()
                  : Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(75, 25, 75, 25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: file != null
                                ? ClipRRect(child: Image.file(file))
                                : imagePicker()),
                        ElevatedButton(
                          onPressed: () => this.setState(() {
                            file = null;
                          }),
                          child:
                              Icon(Icons.clear, size: 25, color: Colors.white),
                        ),
                      ],
                    )),
              SizedBox(height: 50),
              Container(
                width: 300,
                child: TextFormField(
                  controller: descriptionController,
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

  InkWell imagePicker() {
    return InkWell(
      onTap: () {
        selectPhoto();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(75, 25, 75, 25),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add, size: 100, color: Colors.white),
      ),
    );
  }
}
