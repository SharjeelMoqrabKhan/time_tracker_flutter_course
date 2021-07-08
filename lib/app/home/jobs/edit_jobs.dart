import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key, this.job, @required this.database})
      : super(key: key);
  final Job job;
  final Database database;
  static Future<void> show(BuildContext context,
      {Database database, Job job}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(
          database: database,
          job: job,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();
  String _jobName;
  int _ratePerHour;
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _jobName = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final job = await widget.database.jobsStream().first;
        final allNames = job.map((e) => e.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_jobName)) {
          showAlertDialog(
            context,
            title: "Name is already used",
            content: "Please choose any other name",
            defaultActionButton: 'Ok',
          );
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _jobName, ratePerHour: _ratePerHour);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertBox(
          context,
          title: "Operation Failed",
          exception: e,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job == null ? "New Job" : "Edit Job"),
        actions: [
          FlatButton(
            onPressed: _submit,
            child: Text(
              "Save",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: buildBuildContent(),
    );
  }

  buildBuildContent() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0), child: _buildForm()),
          ),
        ),
      );
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildern(),
      ),
    );
  }

  List<Widget> _buildFormChildern() {
    return [
      TextFormField(
        decoration: InputDecoration(hintText: "Job Name"),
        initialValue: _jobName,
        validator: (value) => value.isNotEmpty ? null : 'Can\'t be empty ',
        onSaved: (value) => _jobName = value,
      ),
      TextFormField(
        decoration: InputDecoration(hintText: "Rate Per Hour"),
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
