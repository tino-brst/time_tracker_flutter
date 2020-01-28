import 'package:flutter/foundation.dart';

class Entry {
  final String id;
  final String jobId;
  final DateTime startTime;
  final DateTime endTime;
  final String comment;

  const Entry({
    @required this.id,
    @required this.jobId,
    @required this.startTime,
    @required this.endTime,
    @required this.comment,
  });

  Duration get duration {
    return endTime.difference(startTime);
  }
}
