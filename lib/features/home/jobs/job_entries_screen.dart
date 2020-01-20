import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/entry.dart';
import '../../../entities/job.dart';
import '../../../services/database_service.dart';
import '../../../widgets/dismissible_ink_well.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/generic_list_view.dart';
import 'edit_job_screen.dart';
import 'job_entry_list_item.dart';

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
      onPressed: () => _editJob(context, job),
    );

    final emptyListTitle = 'No entries yet';
    final emptyListSubtitle = 'You can create a new one \ntapping the + button';
    final emptyListBody = EmptyState(title: emptyListTitle, subtitle: emptyListSubtitle);

    final loadingListBody = Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        // TODO the title should update after editing the job name
        title: Text(job.name),
        elevation: 0,
        actions: <Widget>[editButton],
      ),
      body: StreamBuilder<List<Entry>>(
        stream: databaseService.getEntriesStream(job.id),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return loadingListBody;

          final entries = snapshot.data;
          if (entries.isEmpty) return emptyListBody;

          return GenericListView<Entry>(
            items: entries,
            itemBuilder: (context, entry) {
              return DismissibleInkWell(
                key: Key(entry.id),
                onDismissed: () => _deleteEntry(databaseService, entry.id),
                onTap: () {},
                child: JobEntryListItem(job, entry),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _newEntry,
      ),
    );
  }

  // TODO implement NewEntry/EditEntry screen

  void _newEntry() {
    databaseService.addEntry(
      jobId: job.id,
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: Random().nextInt(20))),
      comment: 'Lorem ipsum dolor sit amet',
    );
  }

  void _deleteEntry(DatabaseService databaseService, String entryId) {
    databaseService.deleteEntry(entryId);
  }

  void _editJob(BuildContext context, Job job) {
    EditJobScreen.show(context, databaseService, job);
  }
}
