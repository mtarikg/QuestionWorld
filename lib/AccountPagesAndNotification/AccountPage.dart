import 'package:flutter/material.dart';
import 'package:question_world/Core/questionDetail.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
              height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                ),
child: Image.network("https://cdn.pixabay.com/photo/2021/05/19/14/31/dandelion-6266230_960_720.jpg",fit: BoxFit.cover,),
              ),

            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1,color: Colors.grey),bottom: BorderSide(width: 1,color: Colors.grey))
                ),
                width: MediaQuery.of(context).size.width,
                height: 50
                ,child: Center(child: Text("Username",style: TextStyle(fontSize: 20,color: Colors.black87),)),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Colors.grey))
              ),
              width: MediaQuery.of(context).size.width,
              height: 50
              ,child: Center(child: Text("School name",style: TextStyle(fontSize: 20,color: Colors.black87),)),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: Colors.grey))
              ),
              width: MediaQuery.of(context).size.width,
              height: 50
              ,child: Center(child: Text("Social Media Accounts",style: TextStyle(fontSize: 20,color: Colors.black87),)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(40),
            child: Center(child: Text("My Questions",style: TextStyle(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.bold),)),

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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 230,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Image.network(
                        "https://picsum.photos/250?image=9",
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
                              Icon(Icons.person),
                              Text(
                                "Username",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text("Please help this question."),),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}
