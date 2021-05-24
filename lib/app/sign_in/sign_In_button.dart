import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_rasied_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton(
      {String text, Color color, Color textColor, VoidCallback onPressed})
      : super(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          color: color,
          height: 40.0,
          onPressed: onPressed,
        );
}
