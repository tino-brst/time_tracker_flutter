import 'package:cloud_firestore/cloud_firestore.dart';
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

  JobModel.fromDocument(DocumentSnapshot document)
      : super(
          id: document.documentID,
          name: document.data['name'] as String,
          ratePerHour: document.data['ratePerHour'] as int,
        );

  Map<String, dynamic> toDocumentData() => {
        'name': name,
        'ratePerHour': ratePerHour,
      };
}
