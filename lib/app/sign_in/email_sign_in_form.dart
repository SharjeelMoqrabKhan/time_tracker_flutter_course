import 'package:flutter/material.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration:
            InputDecoration(labelText: "Email", hintText: "test@gmail.com"),
      ),
      TextField(
        decoration: InputDecoration(
          hintText: "Password",
        ),
        obscureText: true,
      ),
      RaisedButton(
        onPressed: () {},
        child: Text("Sign in"),
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
