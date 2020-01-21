import 'package:flutter/material.dart';

import '../../../entities/job.dart';
import '../../../services/database_service.dart';
import '../../../widgets/platform_alert_dialog.dart';

class EditJobScreen extends StatefulWidget {
  final Job job;
  final DatabaseService _databaseService;

  const EditJobScreen(this._databaseService, {this.job});

  @override
  _EditJobScreenState createState() => _EditJobScreenState();

  static Future<void> show(BuildContext context, DatabaseService databaseService, [Job job]) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => EditJobScreen(databaseService, job: job),
      ),
    );
  }
}

class _EditJobScreenState extends State<EditJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ratePerHourFocusNode = FocusNode();

  String _name;
  int _ratePerHour;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _ratePerHourFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNewJob = widget.job == null;
    final appBarTitle = isNewJob ? 'New Job' : 'Edit Job';
    final isFirstFieldAutofocusEnabled = isNewJob;
    final initialNameValue = widget.job?.name;
    final initialRatePerHourValue = widget.job?.ratePerHour?.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            onPressed: _save,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: initialNameValue,
                      enabled: !_isLoading,
                      validator: _nameValidator,
                      autofocus: isFirstFieldAutofocusEnabled,
                      onSaved: (value) => _name = value,
                      decoration: const InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _focusOn(_ratePerHourFocusNode),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: initialRatePerHourValue,
                      enabled: !_isLoading,
                      validator: _ratePerHourValidator,
                      focusNode: _ratePerHourFocusNode,
                      onSaved: (value) => _ratePerHour = int.parse(value),
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                      decoration: const InputDecoration(labelText: 'Rate per hour'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _set({@required bool isLoading}) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _save() async {
    final form = _formKey.currentState;
    final isFormValid = form.validate();

    if (isFormValid) {
      form.save();
      // TODO could be done as part of the addJob database service method, which could throw an exception
      final databaseService = widget._databaseService;
      final job = widget.job;
      final isJobNameTaken = !await databaseService.checkIsJobNameUnique(_name);
      final isEditingExistingJob = job != null;

      if (isEditingExistingJob) {
        _set(isLoading: true);
        await databaseService.updateJob(
          id: job.id,
          name: _name,
          ratePerHour: _ratePerHour,
        );
        Navigator.of(context).pop();
      } else {
        if (isJobNameTaken) {
          await PlatformAlertDialog(
            title: 'Name Already Taken',
            content: 'Please choose a different name',
            primaryActionText: 'OK',
          ).show(context);
        } else {
          _set(isLoading: true);
          await widget._databaseService.addJob(
            name: _name,
            ratePerHour: _ratePerHour,
          );
          Navigator.of(context).pop();
        }
      }
    }
  }

  void _focusOn(FocusNode nextField) {
    FocusScope.of(context).requestFocus(nextField);
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
