import 'package:flutter/material.dart';

import '../../../entities/job.dart';
import 'job_list_tile.dart';

class JobsListView extends StatelessWidget {
  final List<Job> jobs;

  const JobsListView({@required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (_, index) => JobListTile(jobs[index]),
    );
  }
}
