import 'package:flutter/foundation.dart';

import '../entities/entry.dart';
import '../entities/job.dart';

abstract class DatabaseService {
  // Jobs
  Stream<List<Job>> getJobsStream();
  Future<void> addJob({@required String name, @required int ratePerHour});
  Future<void> updateJob({@required String id, @required String name, @required int ratePerHour});
  Future<void> deleteJob({@required String id});

  // Job Entries
  Stream<List<Entry>> getEntriesStream(String jobId);
  Future<void> addEntry({
    @required String jobId,
    @required DateTime startTime,
    @required DateTime endTime,
    String comment,
  });
  Future<void> updateEntry({
    @required String entryId,
    @required String jobId,
    @required DateTime startTime,
    @required DateTime endTime,
    @required String comment,
  });
  Future<void> deleteEntry(String id);

  // Utils
  Future<bool> checkIsJobNameUnique(String jobName);
}
