import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/job.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_service.dart';
import '../../../widgets/custom_list_view.dart';
import '../../../widgets/empty_list_state.dart';
import '../../../widgets/platform_alert_dialog.dart';
import 'edit_job_screen.dart';

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
        onPressed: () => _createNewJob(context),
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

          if (jobs.isEmpty) {
            return EmptyListState(
              title: 'No jobs yet',
              subtitle: 'You can create a new one tapping the + button',
            );
          }

          return CustomListView<Job>(
            items: jobs,
            itemBuilder: (context, job) {
              return Dismissible(
                key: Key(job.id),
                direction: DismissDirection.endToStart,
                background: Container(color: Colors.red),
                onDismissed: (_) => _deleteJob(databaseService, job),
                child: ListTile(
                  title: Text(job.name),
                  onTap: () => _editJob(context, job),
                  contentPadding: EdgeInsets.only(left: 16, right: 10),
                  trailing: Icon(Icons.chevron_right),
                ),
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

  void _createNewJob(BuildContext context) async {
    await EditJobScreen.show(context);
  }

  void _editJob(BuildContext context, Job job) async {
    await EditJobScreen.show(context, job);
  }

  void _deleteJob(DatabaseService databaseService, Job job) {
    databaseService.deleteJob(id: job.id);
  }
}
