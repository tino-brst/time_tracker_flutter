import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/entities/job.dart';
import 'package:time_tracker/features/home/jobs/jobs_screen.dart';
import 'package:time_tracker/services/database_service.dart';
import 'package:time_tracker/widgets/empty_state.dart';
import 'package:time_tracker/widgets/generic_list_view.dart';

import '../../../utils.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('JobsScreen', () {
    testWidgets('shows a loading indicator when there are no jobs available yet', (tester) async {
      final databaseService = MockDatabaseService();

      when(
        databaseService.getJobsStream(),
      ).thenAnswer(
        (_) => null,
      );

      await pumpJobsScreen(tester, databaseService);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows an empty state when the jobs list is empty', (tester) async {
      final databaseService = MockDatabaseService();

      when(
        databaseService.getJobsStream(),
      ).thenAnswer(
        (_) => Stream.value([]),
      );

      await pumpJobsScreen(tester, databaseService);
      await tester.pump();

      expect(find.byType(EmptyState), findsOneWidget);
    });

    testWidgets('shows a list of jobs when there are jobs to show', (tester) async {
      final databaseService = MockDatabaseService();

      when(
        databaseService.getJobsStream(),
      ).thenAnswer(
        (_) => Stream.value([const Job(id: '42', name: 'job', ratePerHour: 42)]),
      );

      await pumpJobsScreen(tester, databaseService);
      await tester.pump();

      expect(find.byType(typeOf<GenericListView<Job>>()), findsOneWidget);
    });
  });
}

Future<void> pumpJobsScreen(WidgetTester tester, DatabaseService databaseService) {
  return tester.pumpWidget(
    MaterialApp(
      home: Provider<DatabaseService>(
        create: (_) => databaseService,
        child: JobsScreen(),
      ),
    ),
  );
}
