import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  StorageReference _storage = FirebaseStorage.instance.ref();
  String imageID;

  Future<String> uploadImage(File image) async {
    imageID = Uuid().v4();
    StorageUploadTask uploadManager =
        _storage.child("questions/question_$imageID.jpg").putFile(image);
    StorageTaskSnapshot snapshot = await uploadManager.onComplete;
    String uploadedImageURL = await snapshot.ref.getDownloadURL();
    return uploadedImageURL;
  }
}
