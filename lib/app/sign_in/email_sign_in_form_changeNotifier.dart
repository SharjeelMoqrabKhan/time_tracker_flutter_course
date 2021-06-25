import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_change_model%20.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_sign_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInFormChangeNotifer extends StatefulWidget {
  EmailSignInFormChangeNotifer({Key key, @required this.model}) : super(key: key);
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifer(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotiferState createState() =>
      _EmailSignInFormChangeNotiferState();
}

class _EmailSignInFormChangeNotiferState extends State<EmailSignInFormChangeNotifer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertBox(context, title: 'Sign In Failed', exception: e);
    }
  }

  void _toggle() {
    widget.model.toogleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingCompleted() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
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
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(
        height: 10,
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toggle : null,
        child: Text(model.secondryButtonText),
      )
    ];
  }

  TextField _buildEmailField() {
    return TextField(
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingCompleted(),
      onChanged: widget.model.updateEmail,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "test@gmail.com",
        enabled: model.isLoading == false,
        errorText: model.emailErrorText,
      ),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildPasswordFeild() {
    return TextField(
        focusNode: _passwordFocusNode,
        onChanged: widget.model.updatePassword,
        onEditingComplete: _submit,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: model.passwordErrorText,
          enabled: model.isLoading == false,
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
}
