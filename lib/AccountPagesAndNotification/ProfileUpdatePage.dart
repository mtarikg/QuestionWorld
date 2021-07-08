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
class ProfileUpdatePage extends StatefulWidget {
  final String profileOwnerId;

  const ProfileUpdatePage({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _ProfileUpdatePageState createState() => _ProfileUpdatePageState();
}


class _ProfileUpdatePageState extends State<ProfileUpdatePage> {


  TextEditingController customController1=TextEditingController();
  TextEditingController customController2=TextEditingController();
  TextEditingController customController3=TextEditingController();



  Future<String> createAlertDialog2(BuildContext context) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Please Enter Your New UserName"),
        content: TextFormField(
          controller:customController1 ,

        ),
        actions: [
          MaterialButton(
            elevation: 5,
            child: Text("Change"),
            onPressed: () {
              setState(() {
                userName=customController1.text;
              });

             updateUserName();
              Navigator.of(context).pop(customController1.text.toString());


            },
          )
        ],

      );
    });
  }

  Future<String> createAlertDialog3(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Please Enter Your New Instagram UserName"),
        content: TextFormField(
          controller: customController2 ,


        ),
        actions: [
          MaterialButton(
            elevation: 5,
            child: Text("Change"),
            onPressed: (){
              setState(() {
                instagramUsername=customController2.text;
              });
              updateIUserName();
              Navigator.of(context).pop(customController2.text.toString());

            },
          )
        ],

      );
    });
  }

  Future<String> createAlertDialog4(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Please Enter Your New School Name"),
        content: TextFormField(
          controller: customController3 ,


        ),
        actions: [
          MaterialButton(
            elevation: 5,
            child: Text("Change"),
            onPressed: (){
              setState(() {
                schoolName=customController3.text;
              });
              updateSchool();
              Navigator.of(context).pop(customController3.text.toString());


            },
          )
        ],

      );
    });
  }
  String userName,instagramUsername,email,imageUrl,schoolName;
  uploadImage() async{
    final _picker=ImagePicker();
    final _storage=FirebaseStorage.instance;
    PickedFile image;
    await Permission.photos.request();
    var permissionStatus=await Permission.photos.status;
    if(permissionStatus.isGranted){
      image=await _picker.getImage(source: ImageSource.gallery);
      var file=File(image.path);
      if(image !=null){
        var snapshot=await _storage.ref().child('newImages/newImage').putFile(file).onComplete;
        var downloadUrl=await snapshot.ref.getDownloadURL().then((value) {
          setState(() {
            imageUrl=value;
          });
           Firestore.instance.collection('users').document(widget.profileOwnerId).updateData({
            'photoUrl':imageUrl
          });
        });


      }
      else{
      print('no path received');
      }
    }
    else{
      print('grant permission and try again');


    }
  }

  void updateIUserName()async{
    await Firestore.instance.collection('users').document(widget.profileOwnerId).updateData({
      'instagram':instagramUsername
    });
  }
  void updateUserName()async{

    await Firestore.instance.collection('users').document(widget.profileOwnerId).updateData({
      'userName':userName
    });
  }

  void updateSchool()async{
    await Firestore.instance.collection('users').document(widget.profileOwnerId).updateData({
      'school':schoolName
    });
  }
  void updateEmail()async{
    await Firestore.instance.collection('users').document(widget.profileOwnerId).updateData({
      'email':email
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreService().getUser(widget.profileOwnerId),
        builder: (context,snapshot){
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
            return _Info(snapshot.data,context);

        },
      )
    );
  }
  Widget _Info(User profileData,BuildContext context){
    return Column(

      children: [
       SizedBox(
         height: 100,

       )
      ,Container(
        child: Center(
          child: Text("Update Profile",style: TextStyle(
            fontSize: 45,
            color: Colors.blue,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
        SizedBox(
          height: 25,

        ),
        Center(
          child: Stack(
            children: [
              Container(
    width: 130,
                height: 130,
                decoration:BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Colors.transparent
                  ),
                )
                ,child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 60,
                  backgroundImage: profileData.photoUrl.isNotEmpty
                      ? NetworkImage(profileData.photoUrl)
                      : AssetImage("assets/images/user.jpeg"),
                ),

              ),
              Positioned(
    child: Container(

                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.blue
                  )
                ),
                child:IconButton(
                icon:Icon(Icons.edit,color: Colors.blue,),
                  onPressed: uploadImage,
    )
              ),
                bottom: 0 ,
                right: 0,
              )

            ],
          )
        ),
        SizedBox(
          height: 25,

        ),


        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.blue
              ,borderRadius: BorderRadius.all(
              Radius.circular(20)
          )
          ),
          width: 360,
          child: FlatButton(onPressed: () {createAlertDialog2(context);


            },
            child:Center(child: Text("Change Your Username",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
          ),
        ),
        SizedBox(
          height: 25,

        ),

        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.blue
              ,borderRadius: BorderRadius.all(
              Radius.circular(20)
          )
          ),
          width: 360,
          child: FlatButton(onPressed: (){createAlertDialog3(context);

            }
            ,
            child:Center(child: Text("Change Your Instagram UserName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
          ),
        ),
        SizedBox(
          height: 25,

        ),

        Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.blue
              ,borderRadius: BorderRadius.all(
              Radius.circular(20)
          )
          ),
          width: 360,
          child: FlatButton(onPressed: () {createAlertDialog4(context);},
            child:Center(child: Text("Change Your School Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white ),)),
          ),
        ),

        SizedBox(
          height: 25,

        )




      ],
    );
  }
}
