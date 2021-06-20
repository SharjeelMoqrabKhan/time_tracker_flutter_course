import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidator {
  EmailSignInModel(
      {this.email = "",
      this.password = "",
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false});
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

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

  EmailSignInModel copywith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
