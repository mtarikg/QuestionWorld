import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;
  final time = DateTime.now();

  Future<void> createUser({id, email, userName}) async {
    await _firestore.collection("users").document(id).setData({
      "userName": userName,
      "email": email,
      "photoUrl": "",
      "school": "",
      "instagram": "",
      "createdTime": time
    });
  }
}
