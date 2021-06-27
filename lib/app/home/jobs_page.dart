import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSingOut(BuildContext context) async {
    final didSignOutRequest = await showAlertDialog(context,
        title: "Logout",
        content: "Are you sure to logout?",
        defaultActionButton: "Logout",
        cancleActionText: "Cancle");
    if (didSignOutRequest == true) {
      _signOut(context);
    }
  }

  void _createJob() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              _confirmSingOut(context);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createJob,
        child: Icon(Icons.add),
      ),
    );
  }
}
