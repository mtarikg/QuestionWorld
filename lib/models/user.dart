import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {
  final String id;
  final String userName;
  final String photoUrl;
  final String email;
  final String school;
  final String instagram;

  User(
      {@required this.id,
      this.userName,
      this.photoUrl,
      this.email,
      this.school,
      this.instagram});

  factory User.createFromFirebase(FirebaseUser user) {
    return User(
      id: user.uid,
      userName: user.displayName,
      photoUrl: user.photoUrl,
      email: user.email,
    );
  }

  factory User.createFromDocument(DocumentSnapshot doc) {
    return User(
        id: doc.documentID,
        userName: doc['userName'],
        email: doc['email'],
        photoUrl: doc['fotoUrl'],
        school: doc['hakkinda'],
        instagram: doc['instagram']);
  }
}
