import 'package:flutter/material.dart';

import '../../../entities/job.dart';
import 'edit_job_screen.dart';
import 'job_list_tile.dart';

class JobsListView extends StatelessWidget {
  final List<Job> jobs;

  const JobsListView({@required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (_, index) {
        final job = jobs[index];
        return JobListTile(job, onTap: () => _editJob(context, job));
      },
    );
  }

  void _editJob(BuildContext context, Job job) async {
    await EditJobScreen.show(context, job);
  }
}
