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

  void _submit() {
    if (_validateAndSaveForm()) {
      print("Saved form name: $_jobName ratePerHour: $_ratePerHour ");
    }
    //TODO: SUBMIT DATA TO FIRESTORE
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
