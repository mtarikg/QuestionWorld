import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String postPhotoUrl;
  final String description;
  final String senderId;
  final String category;

  Post(
      {this.id,
      this.postPhotoUrl,
      this.description,
      this.senderId,
      this.category});

  factory Post.createFromDocument(DocumentSnapshot doc) {
    return Post(
        id: doc.documentID,
        postPhotoUrl: doc["postPhotoUrl"],
        description: doc["description"],
        senderId: doc["senderId"],
        category: doc["category"]);
  }
}
