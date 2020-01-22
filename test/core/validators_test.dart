import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/core/validators.dart';

void main() {
  group('NonEmptyStringValidator', () {
    test('considers valid a non empty string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isValid('foobar'), true);
    });

    test('considers invalid an empty string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isValid(''), false);
    });

    test('considers invalid a null input', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isValid(null), false);
    });
  });
}
