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

  Future<User> signUpWithEmail(String email, String password) async {
    var signUp = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _createUser(signUp.user);
  }

  Future<User> signInWithEmail(String email, String password) async {
    var signUp = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _createUser(signUp.user);
  }

  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }
}
