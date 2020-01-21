import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entities/entry.dart';

class EntryModel extends Entry {
  EntryModel({
    @required String id,
    @required String jobId,
    @required DateTime startTime,
    @required DateTime endTime,
    @required String comment,
  }) : super(
          id: id,
          jobId: jobId,
          startTime: startTime,
          endTime: endTime,
          comment: comment,
        );

  EntryModel.fromDocument(DocumentSnapshot document)
      : super(
          id: document.documentID,
          jobId: document.data['jobId'] as String,
          startTime: DateTime.fromMillisecondsSinceEpoch(document.data['startTime'] as int),
          endTime: DateTime.fromMillisecondsSinceEpoch(document.data['endTime'] as int),
          comment: document.data['comment'] as String,
        );

  Map<String, dynamic> toDocumentData() => {
        'jobId': jobId,
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': endTime.millisecondsSinceEpoch,
        'comment': comment,
      };
}
