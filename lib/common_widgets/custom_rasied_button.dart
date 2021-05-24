import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;

  const CustomRaisedButton(
      {Key key,
      this.color,
      this.borderRadius: 8.0,
      this.onPressed,
      this.child,
      this.height: 50})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          "Sign in with google",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
