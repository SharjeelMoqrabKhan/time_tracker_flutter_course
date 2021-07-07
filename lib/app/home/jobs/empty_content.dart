import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String title;
  final String mesg;

  const EmptyContent(
      {Key key, this.title = "Nothing Here", this.mesg = "Add a new activity"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 48, color: Colors.grey),
          ),
          Text(
            mesg,
            style: TextStyle(
                fontSize: 22, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
