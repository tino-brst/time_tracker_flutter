import 'package:flutter/foundation.dart';

class Job {
  final String id;
  final String name;
  final int ratePerHour;

  Job({
    @required this.id,
    @required this.name,
    @required this.ratePerHour,
  })  : assert(id != null),
        assert(name != null),
        assert(ratePerHour != null);

  @override
  String toString() {
    return 'id: $id, name: $name, ratePerHour: $ratePerHour';
  }
}
