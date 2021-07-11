import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:question_world/models/user.dart';
import 'package:uuid/uuid.dart';

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

  Future<List<DocumentSnapshot>> getCurrentCategories() async {
    final QuerySnapshot qs =
        await _firestore.collection("categories").getDocuments();
    final List<DocumentSnapshot> docSnap = qs.documents;
    return docSnap;
  }

  Future<List<DocumentSnapshot>> getCurrentQuestions(
      String questionCategory) async {
    final QuerySnapshot qs = await _firestore
        .collection("categories")
        .document(questionCategory.toLowerCase())
        .collection("questions")
        .getDocuments();
    final List<DocumentSnapshot> docSnap = qs.documents;
    return docSnap;
  }

  Future<List<DocumentSnapshot>> getCurrentAnswers(question) async {
    final QuerySnapshot qs = await _firestore
        .collection("categories")
        .document(question["categoryName"].toString().toLowerCase())
        .collection("questions")
        .document(question["questionID"].toString())
        .collection("answers")
        .getDocuments();
    final List<DocumentSnapshot> docSnap = qs.documents;
    return docSnap;
  }

  Future<void> createNewQuestion(
      {imageURL, description, userID, questionCategory}) async {
    var questionID = Uuid().v4();
    await _firestore
        .collection("categories")
        .document(questionCategory.toString().toLowerCase())
        .collection("questions")
        .document(questionID)
        .setData({
      "questionID": questionID,
      "imageURL": imageURL,
      "description": description,
      "userID": userID,
      "categoryName": questionCategory,
    });
  }

  Future<void> createNewAnswer(
      {question, imageURL, description, userID}) async {
    var answerID = Uuid().v4();
    await _firestore
        .collection("categories")
        .document(question["categoryName"].toString().toLowerCase())
        .collection("questions")
        .document(question["questionID"])
        .collection("answers")
        .document(answerID)
        .setData({
      "answerID": answerID,
      "imageURL": imageURL,
      "description": description,
      "userID": userID,
    });
  }
}
