import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage('Main Page'),
    );
  }
}

class MainPage extends StatelessWidget {
  final String title;
  final categories = [
    "Math",
    "Literature",
    "English",
    "Geography",
    "History",
    "Spanish",
  ];

  MainPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categories.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 150,
                      height: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return InsideCategory(categories[index]);
                          }));
                        },
                        child: Text(categories[index]),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

class InsideCategory extends StatelessWidget {
  final categoryName;

  InsideCategory(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: Center(
        child: Text("You are in " + categoryName + " page!"),
      ),
    );
  }
}
