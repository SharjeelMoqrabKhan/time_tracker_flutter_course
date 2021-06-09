import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_sign_in_button.dart';

class EmailSignInForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onSubmit() {
    print(
        "Email: ${_emailController.text} Password ${_passwordController.text}");
  }

  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration:
            InputDecoration(labelText: "Email", hintText: "test@gmail.com"),
        controller: _emailController,
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        decoration: InputDecoration(
          hintText: "Password",
        ),
        controller: _passwordController,
        obscureText: true,
      ),
      SizedBox(
        height: 10,
      ),
      FormSubmitButton(
        text: "Sign In",
        onPressed: _onSubmit,
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildChildren(),
        ),
      ),
    );
  }
}
