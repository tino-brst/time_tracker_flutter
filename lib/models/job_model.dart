import 'package:flutter/foundation.dart';

import '../entities/job.dart';

class JobModel extends Job {
  JobModel({
    @required String id,
    @required String name,
    @required int ratePerHour,
  }) : super(
          id: id,
          name: name,
          ratePerHour: ratePerHour,
        );

  JobModel.fromJsonWithId(Map<String, dynamic> json, String id)
      : super(
          id: id,
          name: json['name'],
          ratePerHour: json['ratePerHour'],
        );

  Map<String, dynamic> toJsonWithoutId() => {
        'name': name,
        'ratePerHour': ratePerHour,
      };
}
