import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entities/entry.dart';
import '../entities/job.dart';
import '../models/entry_model.dart';
import '../models/job_model.dart';
import 'database_service.dart';

class FirestoreDatabaseService implements DatabaseService {
  final _firestore = Firestore.instance;
  final String _userId;
  CollectionReference _jobsCollection;
  CollectionReference _entriesCollection;

  FirestoreDatabaseService({@required String userId}) : _userId = userId {
    _jobsCollection = _firestore.collection(Path.jobs(_userId));
    _entriesCollection = _firestore.collection(Path.entries(_userId));
  }

  @override
  Stream<List<Job>> getJobsStream() {
    return _jobsCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return JobModel.fromDocumentDataAndId(document.data, document.documentID);
      }).toList();
    });
  }

  @override
  Stream<List<Entry>> getEntriesStream(String jobId) {
    return _entriesCollection.where('jobId', isEqualTo: jobId).snapshots().map((snapshot) {
      return snapshot.documents.map((document) {
        return EntryModel.fromDocumentDataAndId(document.data, document.documentID);
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
    // Delete job entries
    // TODO investigate if this could be optimized to be a single firestore operation
    final jobEntries = await getEntriesStream(id).first;
    for (final entry in jobEntries) {
      _entriesCollection.document(entry.id).delete();
    }
    // Delete job itself
    await _jobsCollection.document(id).delete();
  }

  @override
  Future<bool> checkIsJobNameUnique(String jobName) async {
    final jobsList = await getJobsStream().first;
    if (jobsList.isEmpty) return true;

    final jobsNames = jobsList.map((job) => job.name.trim().toLowerCase());
    return !jobsNames.contains(jobName.trim().toLowerCase());
  }

  @override
  Future<void> addEntry({
    @required String jobId,
    @required DateTime startTime,
    @required DateTime endTime,
    String comment,
  }) {
    return _setEntry(
      jobId: jobId,
      startTime: startTime,
      endTime: endTime,
      comment: comment,
    );
  }

  @override
  Future<void> updateEntry({
    @required String entryId,
    @required String jobId,
    @required DateTime startTime,
    @required DateTime endTime,
    @required String comment,
  }) {
    return _setEntry(
      id: entryId,
      jobId: jobId,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  Future<void> deleteEntry(String id) async {
    await _entriesCollection.document(id).delete();
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
      ).toDocumentData(),
    );
  }

  Future<void> _setEntry({
    String id,
    @required String jobId,
    @required DateTime startTime,
    @required DateTime endTime,
    String comment,
  }) {
    final entryId = id ?? _generateDocumentIdFromCurrentDate();
    final entryDocument = _entriesCollection.document(entryId);
    return entryDocument.setData(
      EntryModel(
        id: entryId,
        jobId: jobId,
        startTime: startTime,
        endTime: endTime,
        comment: comment,
      ).toDocumentData(),
    );
  }
}

class Path {
  static const _users = 'users';
  static const _jobs = 'jobs';
  static const _entries = 'entries';

  static String jobs(String userId) => '$_users/$userId/$_jobs';
  static String entries(String userId) => '$_users/$userId/$_entries';
}
