import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/model/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_firebase_atuh_exception.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key key, @required this.database}) : super(key: key);
  final Database database;
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJob(
          database: database,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
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

  Future<void> _submit() async {
    try {
      if (_validateAndSaveForm()) {
        final job = Job(name: _jobName, ratePerHour: _ratePerHour);
        await widget.database.createJob(job);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Job"),
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
        validator: (value) => value.isNotEmpty ? null : 'Can\'t be empty ',
        onSaved: (value) => _jobName = value,
      ),
      TextFormField(
        decoration: InputDecoration(hintText: "Rate Per Hour"),
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
