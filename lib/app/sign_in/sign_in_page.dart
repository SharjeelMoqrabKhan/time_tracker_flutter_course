import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_In_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_rasied_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: _buildContainer(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
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
            CustomRaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("images/google-logo.png"),
                  Text("Sign in with Google"),
                  Opacity(
                    opacity: 0.0,
                    child: Image.asset("images/google-logo.png"),
                  ),
                ],
              ),
              color: Colors.white,
              onPressed: () {},
            ),
            SizedBox(
              height: 10.0,
            ),
            SignInButton(
              text: "Sign In With Google",
              textColor: Colors.black,
              color: Colors.white,
              onPressed: () => print("sign in with google"),
            ),
            SizedBox(
              height: 10.0,
            ),
            SignInButton(
              text: "Sign In With Facebook",
              textColor: Colors.white,
              color: Color(0xFF334D92),
              onPressed: () {},
            ),
            SizedBox(
              height: 10.0,
            ),
            SignInButton(
              text: "Sign In With Email",
              textColor: Colors.white,
              color: Colors.teal[700],
              onPressed: () {},
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
