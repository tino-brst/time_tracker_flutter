import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/database_service.dart';
import '../../../widgets/platform_alert_dialog.dart';

class NewJobScreen extends StatefulWidget {
  final DatabaseService _databaseService;

  NewJobScreen(this._databaseService);

  @override
  _NewJobScreenState createState() => _NewJobScreenState();

  static Future<void> show(BuildContext context) async {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);

    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => NewJobScreen(databaseService),
      ),
    );
  }
}

class _NewJobScreenState extends State<NewJobScreen> {
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
                      enabled: !_isLoading,
                      validator: _nameValidator,
                      autofocus: true,
                      onSaved: (value) => _name = value,
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => _focusOn(_ratePerHourFocusNode),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      enabled: !_isLoading,
                      validator: _ratePerHourValidator,
                      focusNode: _ratePerHourFocusNode,
                      onSaved: (value) => _ratePerHour = int.parse(value),
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      decoration: InputDecoration(labelText: 'Rate per hour'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black12,
              child: Center(
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

  void _save() async {
    final form = _formKey.currentState;
    final isFormValid = form.validate();

    if (isFormValid) {
      form.save();
      final isJobNameUnique = await widget._databaseService.checkIsJobNameUnique(_name);

      if (!isJobNameUnique) {
        await PlatformAlertDialog(
          title: 'Name Already Taken',
          content: 'Please choose a different name',
          primaryActionText: 'OK',
        ).show(context);
      } else {
        _set(isLoading: true);
        await widget._databaseService.addJob(name: _name, ratePerHour: _ratePerHour);
        Navigator.of(context).pop();
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
