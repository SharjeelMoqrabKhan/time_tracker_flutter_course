import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

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

  Future<void> _createJob(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.createJob(Job(name: 'Flutter', ratePerHour: 12));
    } on FirebaseException catch (e) {
      showExceptionAlertBox(context, title: 'Operation Failed', exception: e);
    }
  }

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
      body: _buildContext(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.streamJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs.map((job) => Text(job.name)).toList();
          return ListView(children: children);
        }
        if (snapshot.hasData) {
          return Center(
            child: Text("Some Error occured"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
