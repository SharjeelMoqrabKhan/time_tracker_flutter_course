import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_sign_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import './email_sign_in_form_model.dart';

class EmailSignInFormBlocBassed extends StatefulWidget {
  EmailSignInFormBlocBassed({Key key, @required this.bloc}) : super(key: key);
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBassed(bloc: bloc),
      ),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBassedState createState() =>
      _EmailSignInFormBlocBassedState();
}

class _EmailSignInFormBlocBassedState extends State<EmailSignInFormBlocBassed> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

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
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertBox(context, title: 'Sign In Failed', exception: e);
    }
  }

  void _toggle() {
    widget.bloc.toogleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingCompleted(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailField(model),
      SizedBox(
        height: 10,
      ),
      _buildPasswordFeild(model),
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

  TextField _buildEmailField(EmailSignInModel model) {
    return TextField(
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingCompleted(model),
      onChanged: widget.bloc.updateEmail,
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

  TextField _buildPasswordFeild(EmailSignInModel model) {
    return TextField(
        focusNode: _passwordFocusNode,
        onChanged: widget.bloc.updatePassword,
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
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildChildren(model),
              ),
            ),
          );
        });
  }
}
