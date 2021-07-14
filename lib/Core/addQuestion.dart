import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:question_world/Core/mainPage.dart';
import 'package:question_world/services/authorizationService.dart';
import 'package:question_world/services/firestoreService.dart';
import 'package:question_world/services/storageService.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  bool imageLoaded = false;
  File file;
  String selectedCategory;
  var categories = [];

  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    var categoriesInfo = await FirestoreService().getCurrentCategories();
    setState(() {
      categoriesInfo.forEach((element) {
        categories.add(element["catName"]);
      });
    });
  }

  void changeCategory(newValue) {
    setState(() {
      selectedCategory = newValue;
    });
  }

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

  Future<void> uploadQuestion() async {
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

    await FirestoreService().createNewQuestion(
        imageURL: qImageURL,
        description: descriptionController.text,
        userID: activeUserID,
        questionCategory: selectedCategory);

    setState(() {
      descriptionController.clear();
      file = null;
    });
  }

  void validateQuestion() {
    if (selectedCategory == null ||
        (descriptionController.text == null && file == null)) {
      Widget warningButton = TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"));

      var alert = AlertDialog(
        title: Text("Insufficient information"),
        content: Text("Provide a category along with an image or a text!"),
        actions: [warningButton],
      );

      showDialog(context: context, builder: (BuildContext context) => alert);
    } else {
      alertUser();
    }
  }

  void alertUser() {
    Widget yesButton = TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          await uploadQuestion();
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
    return _postForm();
  }

  Widget _postForm() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (!imageLoaded
                  ? imagePicker()
                  : Stack(alignment: Alignment.topRight, children: [
                      Container(
                          padding: EdgeInsets.fromLTRB(75, 25, 75, 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: file != null
                              ? ClipRRect(
                                  child: Image.file(file),
                                )
                              : imagePicker()),
                      ElevatedButton(
                        onPressed: () => this.setState(() {
                          file = null;
                        }),
                        child: Icon(Icons.clear, size: 25, color: Colors.white),
                      ),
                    ])),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DropdownButtonFormField(
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
              ),
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
                    onPressed: validateQuestion,
                    child: Text(
                      "Add your question",
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
