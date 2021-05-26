import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_rasied_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton(
      {String text,
      @required Color color,
      @required String assetName,
      Color textColor,
      VoidCallback onPressed})
      : super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(assetName),
                Text(
                  text,
                  style: TextStyle(fontSize: 16.0, color: textColor),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image.asset(assetName),
                ),
              ],
            ),
            onPressed: onPressed,
            color: color);
}
