import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:question_world/Core/showQuestions.dart';
import 'package:question_world/services/firestoreService.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var categories = [];

  getCategories() async {
    var categoriesInfo = await FirestoreService().getCurrentCategories();
    setState(() {
      categoriesInfo.forEach((element) {
        categories.add(element["catName"]);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: categories.length == 0
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 30,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ShowQuestions(categories[index]);
                            }));
                          },
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
