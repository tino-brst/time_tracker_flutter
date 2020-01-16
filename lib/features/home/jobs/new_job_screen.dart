import 'package:flutter/material.dart';

import '../../../entities/job.dart';

class NewJobScreen extends StatefulWidget {
  @override
  _NewJobScreenState createState() => _NewJobScreenState();

  static Future<Job> show(BuildContext context) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => NewJobScreen(),
      ),
    );
  }
}

class _NewJobScreenState extends State<NewJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: _save,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: _nameValidator,
                  onSaved: (value) => _name = value,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 12),
                TextFormField(
                  validator: _ratePerHourValidator,
                  onSaved: (value) => _ratePerHour = int.parse(value),
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                  decoration: InputDecoration(labelText: 'Rate per hour'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    final form = _formKey.currentState;
    final isFormValid = form.validate();

    if (isFormValid) {
      form.save();
      Navigator.of(context).pop<Job>(
        Job(
          name: _name,
          ratePerHour: _ratePerHour,
        ),
      );
    }
  }

  String _nameValidator(String name) {
    final isEmpty = name == null || name.trim().isEmpty;
    if (isEmpty) return 'Please enter a name';

    return null;
  }

  String _ratePerHourValidator(String ratePerHour) {
    final isNotANumber = int.tryParse(ratePerHour) == null;
    if (isNotANumber) return 'Please enter a number';

    return null;
  }
}
