import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Stream<User> authStateChanges();
  Future<User> signInWithGoogle();
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
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
            message: "Missing Google Token",
            code: "ERROR_MISSING_GOOGLE_ID_TOKEN");
      }
    } else {
      throw FirebaseAuthException(
          message: "Sign is aborted by user", code: "ERROR_ABORTED BY USER");
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
