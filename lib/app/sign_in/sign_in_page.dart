import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_In_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_manger.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_signIn_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.manger, @required this.isLoading}) : super(key: key);
  final SignInManger manger;
  final bool isLoading;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManger>(
          create: (_) => SignInManger(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManger>(
            builder: (_, manger, __) => SignInPage(manger: manger,isLoading: isLoading.value,),
          ),
        ),
      ),
    );
  }

  void _showSignInErrors(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED BY USER') {
      return;
    }
    showExceptionAlertBox(context,
        title: "SignIn Failed", exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manger.signInAnonymously();
    } catch (e) {
      _showSignInErrors(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manger.signInWithGoogle();
    } catch (e) {
      _showSignInErrors(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manger.signInWithFacebook();
    } catch (e) {
      _showSignInErrors(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: _buildContainer(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                child: _buildHeader(),
              ),
              SizedBox(
                height: 40.0,
              ),
              SocialSignInButton(
                text: "Sign In With Google",
                textColor: Colors.black,
                assetName: 'images/google-logo.png',
                color: Colors.white,
                onPressed: isLoading ? null : () => _signInWithGoogle(context),
              ),
              SizedBox(
                height: 10.0,
              ),
              SocialSignInButton(
                text: "Sign In With Facebook",
                textColor: Colors.white,
                assetName: 'images/facebook-logo.png',
                color: Color(0xFF334D92),
                onPressed:
                    isLoading ? null : () => _signInWithFacebook(context),
              ),
              SizedBox(
                height: 10.0,
              ),
              SignInButton(
                text: "Sign In With Email",
                textColor: Colors.white,
                color: Colors.teal[700],
                onPressed: isLoading ? null : () => _signInWithEmail(context),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "OR",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SignInButton(
                text: "Go Anonymous",
                textColor: Colors.white,
                color: Colors.lime[700],
                onPressed: isLoading ? null : () => _signInAnonymously(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    );
  }
}
