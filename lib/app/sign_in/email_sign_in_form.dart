import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_sign_in_button.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration:
            InputDecoration(labelText: "Email", hintText: "test@gmail.com"),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        decoration: InputDecoration(
          hintText: "Password",
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 10,
      ),
      FormSubmitButton(
        text: "Sign In",
        onPressed: () {},
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        onPressed: () {},
        child: Text("Need an account?Register"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}
