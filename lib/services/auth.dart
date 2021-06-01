import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Stream<User> authStateChanges();
  Future<void> signOut();
}

class Auth implements AuthBase {
  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
