import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_sign_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import './email_sign_in_form_model.dart';

class EmailSignInFormStatefull extends StatefulWidget
    with EmailAndPasswordValidator {
  @override
  _EmailSignInFormStatefullState createState() =>
      _EmailSignInFormStatefullState();
}

class _EmailSignInFormStatefullState extends State<EmailSignInFormStatefull> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInFormType.signIn) {
        final auth = Provider.of<AuthBase>(context, listen: false);
        await auth.signInWithEmailPassword(_email.trim(), _password.trim());
      } else {
        final auth = Provider.of<AuthBase>(context, listen: false);
        await auth.createWithEmailAndPass(_email.trim(), _password.trim());
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertBox(context, title: 'Sign In Failed', exception: e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggle() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingCompleted() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? "Sign In"
        : "Create an account";
    final secondryText = _formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";
    bool signInEnable = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
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
        onPressed: signInEnable ? _onSubmit : null,
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        onPressed: !_isLoading ? _toggle : null,
        child: Text(secondryText),
      )
    ];
  }

  TextField _buildEmailField() {
    bool showTextError = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      onEditingComplete: _emailEditingCompleted,
      onChanged: (email) => _updateState(),
      decoration: InputDecoration(
          labelText: "Email",
          hintText: "test@gmail.com",
          enabled: _isLoading == false,
          errorText: showTextError ? widget.emailError : null),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildPasswordFeild() {
    bool _showTextError =
        _submitted && !widget.emailValidator.isValid(_password);
    return TextField(
        focusNode: _passwordFocusNode,
        onChanged: (password) => _updateState(),
        onEditingComplete: _onSubmit,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: _showTextError ? widget.passwordError : null,
          enabled: _isLoading == false,
        ),
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

  void _updateState() {
    print("updated $_email $_password");
    setState(() {});
  }
}
