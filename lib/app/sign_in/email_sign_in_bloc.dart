import 'dart:async';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_model.dart';

class EmailSignInBloc {
  // creating stream
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  // clossing stream intance
  void dispose() {
    _modelController.close();
  }

  // adding values in stream
  void updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool isLoading,
      bool submitted}) {
    //update model
    _model = _model.copywith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    // add update model to _modelController
    _modelController.add(_model);
  }
}
