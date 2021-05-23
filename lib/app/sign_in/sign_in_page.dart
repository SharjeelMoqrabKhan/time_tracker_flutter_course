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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: SizedBox(
                height: 120,
              ),
              color: Colors.orange,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: SizedBox(
                height: 120,
              ),
              color: Colors.blue,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: SizedBox(
                height: 120,
              ),
              color: Colors.pink,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
