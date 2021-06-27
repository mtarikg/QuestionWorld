import 'package:firebase_auth/firebase_auth.dart';
import 'package:question_world/models/user.dart';

class AuthorizationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _createUser(FirebaseUser user) {
    return user == null ? null : User.createFromFirebase(user);
  }

  Stream<User> get statusTracker {
    return _firebaseAuth.onAuthStateChanged.map(_createUser);
  }
}
