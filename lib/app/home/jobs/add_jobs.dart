import 'package:flutter/material.dart';

class AddJob extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJob(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Job"),
      ),
    );
  }
}
