abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    if (value == null) return false;
    return value.isNotEmpty;
  }
}

mixin EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailText = 'The email cannot be empty';
  final String invalidPasswordText = 'The password cannot be empty';
}
