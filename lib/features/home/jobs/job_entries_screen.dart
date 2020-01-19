import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/job.dart';
import '../../../services/database_service.dart';
import 'edit_job_screen.dart';

class JobEntriesScreen extends StatelessWidget {
  final DatabaseService databaseService;
  final Job job;

  JobEntriesScreen(this.databaseService, this.job);

  static Future<void> show(BuildContext context, Job job) {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);

    return Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (_) => JobEntriesScreen(databaseService, job),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editButton = FlatButton(
      child: Text('Edit', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal)),
      onPressed: () => _edit(context, job),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
        elevation: 0,
        actions: <Widget>[editButton],
      ),
      body: Container(),
    );
  }

  void _edit(BuildContext context, Job job) async {
    await EditJobScreen.show(context, databaseService, job);
  }
}
