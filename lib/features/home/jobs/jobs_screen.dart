import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/job.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_service.dart';
import '../../../widgets/dismissible_list_tile.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/generic_list_view.dart';
import '../../../widgets/platform_alert_dialog.dart';
import 'edit_job_screen.dart';
import 'job_entries_screen.dart';

class JobsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final databaseService = Provider.of<DatabaseService>(context, listen: false);

    final appBarTitle = 'Jobs';
    final appBarActions = <Widget>[
      IconButton(
        icon: Icon(Icons.exit_to_app, color: Colors.white),
        onPressed: () => _signOut(context, authService),
      )
    ];

    final emptyListTitle = 'No jobs yet';
    final emptyListSubtitle = 'You can create a new one \ntapping the + button';
    final emptyListBody = EmptyState(title: emptyListTitle, subtitle: emptyListSubtitle);

    final loadingListBody = Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        elevation: 0,
        actions: appBarActions,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createNewJob(context, databaseService),
      ),
      body: StreamBuilder<List<Job>>(
        stream: databaseService.getJobsStream(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return loadingListBody;

          final jobs = snapshot.data;
          if (jobs.isEmpty) return emptyListBody;

          return GenericListView<Job>(
            items: jobs,
            itemBuilder: (context, job) {
              return DismissibleListTile(
                title: job.name,
                key: Key(job.id),
                onDismissed: () => _deleteJob(databaseService, job),
                onTap: () => _goToJobEntries(context, job),
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

  void _createNewJob(BuildContext context, databaseService) async {
    await EditJobScreen.show(context, databaseService);
  }

  void _goToJobEntries(BuildContext context, Job job) async {
    await JobEntriesScreen.show(context, job);
  }

  void _deleteJob(DatabaseService databaseService, Job job) {
    databaseService.deleteJob(id: job.id);
  }
}
