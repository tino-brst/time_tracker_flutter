import 'package:flutter/foundation.dart';

import '../entities/job.dart';

class JobModel extends Job {
  const JobModel({
    @required String id,
    @required String name,
    @required int ratePerHour,
  }) : super(
          id: id,
          name: name,
          ratePerHour: ratePerHour,
        );

  JobModel.fromDocumentDataAndId(Map<String, dynamic> data, String id)
      : super(
          id: id,
          name: data['name'] as String,
          ratePerHour: data['ratePerHour'] as int,
        );

  Map<String, dynamic> toDocumentData() => {
        'name': name,
        'ratePerHour': ratePerHour,
      };
}
