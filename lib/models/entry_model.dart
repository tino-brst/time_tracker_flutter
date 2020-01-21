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

  EntryModel.fromDocumentDataAndId(Map<String, dynamic> data, String id)
      : super(
          id: id,
          jobId: data['jobId'] as String,
          startTime: DateTime.fromMillisecondsSinceEpoch(data['startTime'] as int),
          endTime: DateTime.fromMillisecondsSinceEpoch(data['endTime'] as int),
          comment: data['comment'] as String,
        );

  Map<String, dynamic> toDocumentData() => {
        'jobId': jobId,
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': endTime.millisecondsSinceEpoch,
        'comment': comment,
      };
}
