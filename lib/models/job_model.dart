import 'package:flutter/foundation.dart';

import '../entities/job.dart';

class JobModel extends Job {
  JobModel({
    @required String name,
    @required int ratePerHour,
  }) : super(
          name: name,
          ratePerHour: ratePerHour,
        );

  JobModel.fromJson(Map<String, dynamic> json)
      : super(
          name: json['name'],
          ratePerHour: json['ratePerHour'],
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'ratePerHour': ratePerHour,
      };
}
