import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entities/job.dart';
import '../models/job_model.dart';
import 'database_service.dart';

class FirestoreDatabaseService implements DatabaseService {
  final _firestore = Firestore.instance;
  final String _userUid;

  FirestoreDatabaseService({@required userUid}) : _userUid = userUid;

  @override
  Stream<List<Job>> get jobs {
    final jobsCollection = _firestore.collection(Path.userJobs(_userUid));
    return jobsCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return JobModel.fromJson(document.data);
      }).toList();
    });
  }

  @override
  Future<void> addJob({@required String name, @required int ratePerHour}) async {
    final jobsCollection = _firestore.collection(Path.userJobs(_userUid));
    await jobsCollection.add(
      JobModel(
        name: name,
        ratePerHour: ratePerHour,
      ).toJson(),
    );
  }

  @override
  Future<bool> checkIsJobNameUnique(String jobName) async {
    if (await jobs.isEmpty) return true;

    final jobsList = await jobs.first;
    final jobsNames = jobsList.map((job) => job.name.trim().toLowerCase());
    return !jobsNames.contains(jobName.trim().toLowerCase());
  }
}

class Path {
  static const _jobs = 'jobs';
  static const _users = 'users';

  static String get users => '$_users';
  static String userJobs(String userUid) => '$_users/$userUid/$_jobs';
}
