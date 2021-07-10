import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String photoUrl;
  final double radius;

  const Avatar({Key key, this.photoUrl, @required this.radius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      radius: radius,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      child: photoUrl == null
          ? Icon(
              Icons.camera_alt,
              size: radius,
            )
          : null,
    );
  }
}
