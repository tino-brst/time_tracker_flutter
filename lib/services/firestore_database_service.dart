import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entities/job.dart';
import '../models/job_model.dart';
import 'database_service.dart';

class FirestoreDatabaseService implements DatabaseService {
  final _firestore = Firestore.instance;
  final String _userId;
  CollectionReference _jobsCollection;

  FirestoreDatabaseService({@required userId}) : _userId = userId {
    _jobsCollection = _firestore.collection(Path.userJobs(_userId));
  }

  @override
  Stream<List<Job>> get jobs {
    return _jobsCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return JobModel.fromJsonWithId(document.data, document.documentID);
      }).toList();
    });
  }

  @override
  Future<void> addJob({@required String name, @required int ratePerHour}) async {
    await _setJob(
      name: name,
      ratePerHour: ratePerHour,
    );
  }

  @override
  Future<void> updateJob({@required String id, @required String name, @required int ratePerHour}) async {
    await _setJob(
      id: id,
      name: name,
      ratePerHour: ratePerHour,
    );
  }

  @override
  Future<void> deleteJob({@required String id}) async {
    await _jobsCollection.document(id).delete();
  }

  @override
  Future<bool> checkIsJobNameUnique(String jobName) async {
    if (await jobs.isEmpty) return true;

    final jobsList = await jobs.first;
    final jobsNames = jobsList.map((job) => job.name.trim().toLowerCase());
    return !jobsNames.contains(jobName.trim().toLowerCase());
  }

  String _generateDocumentIdFromCurrentDate() {
    return DateTime.now().toIso8601String();
  }

  Future<void> _setJob({String id, @required String name, @required int ratePerHour}) async {
    final jobId = id ?? _generateDocumentIdFromCurrentDate();
    final jobDocument = _jobsCollection.document(jobId);

    await jobDocument.setData(
      JobModel(
        id: jobId,
        name: name,
        ratePerHour: ratePerHour,
      ).toJsonWithoutId(),
    );
  }
}

class Path {
  static const _jobs = 'jobs';
  static const _users = 'users';

  static String get users => '$_users';
  static String userJobs(String userId) => '$_users/$userId/$_jobs';
}
