import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: Column(
        children: [
          Container(
            child: SizedBox(
              width: 20,
              height: 20,
            ),
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}
