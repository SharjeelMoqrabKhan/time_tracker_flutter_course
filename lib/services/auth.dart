import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Stream<User> authStateChanges();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithEmailPassword(String email, String password);
  Future<User> createWithEmailAndPass(String email, String password);
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
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.Success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );
        return userCredential.user;
      case FacebookLoginStatus.Cancel:
        throw FirebaseAuthException(
            code: 'ERROR_ABBORTED_BY_USER', message: 'Sign in aborted by user');
      case FacebookLoginStatus.Error:
        throw FirebaseAuthException(
            code: 'FACEBOOK LOGIN FAILIED',
            message: response.error.developerMessage);
      default:
        throw UnimplementedError();
    }
  }

  @override
  // ignore: missing_return
  Future<User> signInWithEmailPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  // ignore: missing_return
  Future<User> createWithEmailAndPass(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookLogin = FacebookLogin();
    await googleSignIn.signOut();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
