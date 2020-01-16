import 'package:flutter/material.dart';

import '../../../entities/job.dart';

class JobListTile extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobListTile(this.job, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      onTap: onTap,
    );
  }
}
