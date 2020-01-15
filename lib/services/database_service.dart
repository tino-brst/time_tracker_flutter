import 'package:flutter/foundation.dart';

import '../entities/job.dart';

abstract class DatabaseService {
  Stream<List<Job>> get jobs;
  Future<void> addJob({@required String name, @required int ratePerHour});
}
