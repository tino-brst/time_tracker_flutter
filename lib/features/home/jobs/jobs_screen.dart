import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/job.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_service.dart';
import '../../../widgets/platform_alert_dialog.dart';
import 'new_job_screen.dart';

class JobsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final databaseService = Provider.of<DatabaseService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => _signOut(context, authService),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newJob = await NewJobScreen.show(context);
          databaseService.addJob(
            name: newJob.name,
            ratePerHour: newJob.ratePerHour,
          );
        },
      ),
      body: StreamBuilder<List<Job>>(
        stream: databaseService.jobs,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final jobs = snapshot.data;
          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(jobs[index].name),
              );
            },
          );
        },
      ),
    );
  }

  void _signOut(BuildContext context, AuthService authService) async {
    final didConfirmSignOut = await PlatformAlertDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      primaryActionText: 'Sign Out',
      cancelActionText: 'Cancel',
    ).show(context);

    if (didConfirmSignOut) authService.signOut();
  }
}
