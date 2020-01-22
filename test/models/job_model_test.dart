import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/models/job_model.dart';

void main() {
  group('JobModel', () {
    test('.fromDocumentDataAndId creates a JobModel with the correct properties', () {
      const documentData = {'name': 'bar', 'ratePerHour': 42};
      const documentId = 'foobar';

      final actual = JobModel.fromDocumentDataAndId(documentData, documentId);
      final expected = JobModel(id: 'foobar', name: 'bar', ratePerHour: 42);

      expect(actual, equals(expected));
    });

    test('toDocumentData creates a Map with the correct key-value pairs', () {
      final actual = JobModel(id: 'foobar', name: 'bar', ratePerHour: 42).toDocumentData();
      final expected = {'name': 'bar', 'ratePerHour': 42};

      expect(actual, equals(expected));
    });
  });
}
