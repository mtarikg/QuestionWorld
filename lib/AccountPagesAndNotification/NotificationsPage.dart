import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
class NotificationsPage extends StatefulWidget {

  NotificationsPage({Key key}) : super(key: key);
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final items = List<String>.generate(20, (i) => 'Notification Number ${i + 1}');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
    body: Center(
      child: ListView.builder(
        itemCount: items.length,
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
                child: Text(items[index],style: TextStyle(
          color: Colors.white,
          fontSize: 20,)),
                  ),
              SizedBox(
                height: 15,
              ),
            ],
          );
        },
      ),
    ));

  }
}

