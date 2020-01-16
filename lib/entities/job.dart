import 'package:flutter/foundation.dart';

class Job {
  final String name;
  final int ratePerHour;

  Job({
    @required this.name,
    @required this.ratePerHour,
  });

  @override
  String toString() {
    return 'name: $name, ratePerHour: $ratePerHour';
  }
}
