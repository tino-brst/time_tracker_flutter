import 'package:flutter/material.dart';

import '../../../entities/job.dart';

class JobListTile extends StatelessWidget {
  final Job job;

  const JobListTile(this.job);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
    );
  }
}
