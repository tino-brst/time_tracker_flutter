import 'package:flutter/foundation.dart';

import '../entities/job.dart';

abstract class DatabaseService {
  Stream<List<Job>> get jobs;
  Future<void> addJob({@required String name, @required int ratePerHour});
  Future<void> updateJob({@required String id, @required String name, @required int ratePerHour});
  Future<void> deleteJob({@required String id});
  Future<bool> checkIsJobNameUnique(String jobName);
}
