import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertBox(BuildContext context,
        {@required String title, @required Exception exception}) =>
    showAlertDialog(context,
        title: title, content: _message(exception), defaultActionButton: 'Ok');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}
