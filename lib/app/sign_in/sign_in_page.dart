import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: SizedBox(
              height: 120,
            ),
            color: Colors.orange,
          ),
          Container(
            child: SizedBox(
              height: 120,
            ),
            color: Colors.blue,
          ),
          Container(
            child: SizedBox(
              height: 120,
            ),
            color: Colors.pink,
          ),
        ],
      ),
    );
  }
}
