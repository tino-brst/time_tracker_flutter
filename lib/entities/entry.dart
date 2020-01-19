import 'package:flutter/foundation.dart';

class Entry {
  final String id;
  final String jobId;
  final DateTime startTime;
  final DateTime endTime;
  final String comment;

  Entry({
    @required this.id,
    @required this.jobId,
    @required this.startTime,
    @required this.endTime,
    @required this.comment,
  });
}
