import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:question_world/models/user.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;
  final time = DateTime.now();

  Future<void> createUser({id, email, userName, photoUrl = ""}) async {
    await _firestore.collection("users").document(id).setData({
      "userName": userName,
      "email": email,
      "photoUrl": photoUrl,
      "school": "",
      "instagram": "",
      "createdTime": time
    });
  }

  Future<User> getUser(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").document(id).get();
    if (doc.exists) {
      User user = User.createFromDocument(doc);
      return user;
    }
    return null;
  }
}
