import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_In_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_signIn_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';


class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
     final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
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
              Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.0,
              ),
              SocialSignInButton(
                text: "Sign In With Google",
                textColor: Colors.black,
                assetName: 'images/google-logo.png',
                color: Colors.white,
                onPressed: () => _signInWithGoogle(context),
              ),
              SizedBox(
                height: 10.0,
              ),
              SocialSignInButton(
                text: "Sign In With Facebook",
                textColor: Colors.white,
                assetName: 'images/facebook-logo.png',
                color: Color(0xFF334D92),
                onPressed: () => _signInWithFacebook(context),
              ),
              SizedBox(
                height: 10.0,
              ),
              SignInButton(
                text: "Sign In With Email",
                textColor: Colors.white,
                color: Colors.teal[700],
                onPressed: () => _signInWithEmail(context),
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
                onPressed: () => _signInAnonymously(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
