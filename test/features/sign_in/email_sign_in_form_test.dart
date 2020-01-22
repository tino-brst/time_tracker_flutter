import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/features/sign_in/email_sign_in_form.dart';
import 'package:time_tracker/services/auth_service.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('EmailSignInForm', () {
    testWidgets('does not try to sign in when pressing the sing in button with no email and password', (tester) async {
      final authService = MockAuthService();
      await pumpEmailSignInForm(tester, authService);

      final signInButtonFinder = find.text('Sign in');
      await tester.tap(signInButtonFinder);

      verifyNever(authService.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')));
    });

    testWidgets('tries to sign in when pressing the sing in button after entering email and password', (tester) async {
      final authService = MockAuthService();
      await pumpEmailSignInForm(tester, authService);

      const email = 'foo@bar.com';
      const password = 'foobar';

      final emailFieldFinder = find.byKey(const Key('email'));
      final passwordFieldFinder = find.byKey(const Key('password'));
      final signInButtonFinder = find.text('Sign in');

      await tester.enterText(emailFieldFinder, email);
      await tester.enterText(passwordFieldFinder, password);
      await tester.pump();
      await tester.tap(signInButtonFinder);

      verify(authService.signInWithEmailAndPassword(email: email, password: password));
    });
  });
}

Future<void> pumpEmailSignInForm(WidgetTester tester, AuthService authService) {
  return tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Provider<AuthService>(
        create: (_) => authService,
        child: EmailSignInForm(),
      ),
    ),
  ));
}
