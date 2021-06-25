import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_changeNotifier.dart';


class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 10.0,
      ),
      body: Card(
        child: EmailSignInFormChangeNotifer.create(context),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
