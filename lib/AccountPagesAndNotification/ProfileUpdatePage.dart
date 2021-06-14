import 'dart:ffi';

import 'package:flutter/material.dart';

class ProfileUpdatePage extends StatefulWidget {


  @override
  ProfileUpdatePageState createState() => ProfileUpdatePageState();
}

class ProfileUpdatePageState extends State<ProfileUpdatePage> {
  TextEditingController customController=TextEditingController();
  Future<String> createAlertDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Please Enter The New Value"),
        content: TextField(
          controller: customController ,
        ),
        actions: [
          MaterialButton(
            elevation: 5,
            child: Text("Change"),
            onPressed: (){
              Navigator.of(context).pop(customController.text.toString());
            },
          )
        ],

      );
    });
  }

var username="Username";
var instagramUsername="InstagramUsername";
var FacebookUsername="Facebook Username";
var age="age";
var SchoolName="School Name";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
      child:Column(
      mainAxisAlignment: MainAxisAlignment.center
      ,children: [
          Text("Update Profile",style: TextStyle(color: Colors.blue,fontSize: 50),),
          SizedBox(
            width: double.infinity,
            height: 100,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.blue,
                ),
                child: Image.network("https://cdn.pixabay.com/photo/2021/05/19/14/31/dandelion-6266230_960_720.jpg",fit: BoxFit.cover,),
              ),

            ),
          ),
        SizedBox(
          width: double.infinity,
          height: 75,
        ),
          Card(
            color: Colors.blue ,
            child: Container(
              width: double.infinity,
              height: 60
              ,child:  FlatButton(onPressed:() {createAlertDialog(context).then((value) {
              setState(() {
                username=value;
              });
            });},
                child: Text('$username',style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Card(
            color: Colors.blue ,
            child: Container(
              width: double.infinity,
              height: 60
              ,child:  FlatButton(onPressed:() {createAlertDialog(context).then((value) {
             setState(() {
               FacebookUsername=value;
             });
            });},
                child: Text('$FacebookUsername',style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Card(
            color: Colors.blue ,
            child: Container(
              width: double.infinity,
              height: 60
              ,child:  FlatButton(onPressed:() {createAlertDialog(context).then((value){
                setState(() {
                  instagramUsername=value;
                });
            });}, child: Text('$instagramUsername',style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),
          Card(
            color: Colors.blue ,
            child: Container(
              width: double.infinity,
              height: 60
              ,child:  FlatButton(onPressed:() {createAlertDialog(context).then((value) => {
                setState((){
                  age=value;
                })
            });}, child: Text('$age',style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
          ),

        ],
      ),
      )
    );
  }
}
