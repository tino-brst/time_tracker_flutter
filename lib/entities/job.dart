import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Job extends Equatable {
  final String id;
  final String name;
  final int ratePerHour;

  const Job({
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

  @override
  List<Object> get props => [id, name, ratePerHour];
}
