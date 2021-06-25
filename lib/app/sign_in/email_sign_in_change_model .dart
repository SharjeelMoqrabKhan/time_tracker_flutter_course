import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_model.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInChangeModel with EmailAndPasswordValidator, ChangeNotifier {
  EmailSignInChangeModel(
      {this.email = "",
      this.password = "",
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false,
      @required this.auth});
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  final Auth auth;
  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailPassword(email.trim(), password.trim());
      } else {
        await auth.createWithEmailAndPass(email.trim(), password.trim());
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? "Sign In"
        : "Create an account";
  }

  String get secondryButtonText {
    return formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign In";
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? passwordError : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? emailError : null;
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void toogleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      submitted: false,
      formType: formType,
      isLoading: false,
    );
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
