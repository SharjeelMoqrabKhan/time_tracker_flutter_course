import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;

  const EmailSignInForm({Key key, @required this.auth}) : super(key: key);
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<void> _onSubmit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth
            .signInWithEmailPassword(_email.trim(), _password.trim());
      } else {
        await widget.auth
            .createWithEmailAndPass(_email.trim(), _password.trim());
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toggle() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingCompleted() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? "Sign In"
        : "Create an account";
    final secondryText = _formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";
    return [
      _buildEmailField(),
      SizedBox(
        height: 10,
      ),
      _buildPasswordFeild(),
      SizedBox(
        height: 10,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: _onSubmit,
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        onPressed: _toggle,
        child: Text(secondryText),
      )
    ];
  }

  TextField _buildEmailField() {
    return TextField(
      focusNode: _emailFocusNode,
      onEditingComplete: _emailEditingCompleted,
      decoration:
          InputDecoration(labelText: "Email", hintText: "test@gmail.com"),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildPasswordFeild() {
    return TextField(
        focusNode: _passwordFocusNode,
        onEditingComplete: _onSubmit,
        decoration: InputDecoration(labelText: "Password"),
        obscureText: true,
        controller: _passwordController,
        autocorrect: false,
        textInputAction: TextInputAction.done);
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
