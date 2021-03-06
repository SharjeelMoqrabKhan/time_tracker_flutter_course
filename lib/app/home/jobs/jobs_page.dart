import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/job_entries_page.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/edit_jobs.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/job_tile.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/list_item_builder.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertBox(context, title: 'Operation Failed', exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              EditJobPage.show(
                context,
                database: Provider.of<Database>(context, listen: false),
              );
            },
          ),
        ],
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.startToEnd,
            onDismissed: (dirction) => _delete(context, job),
            child: JobTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }
}
