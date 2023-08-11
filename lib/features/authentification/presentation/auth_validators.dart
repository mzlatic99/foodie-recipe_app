import 'string_validators.dart';

mixin AuthValidators {
  final StringValidator nameSubmitValidator = NonEmptyStringValidator();
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordSubmitValidator = MinLengthStringValidator(6);
  final StringValidator passwordLogInSubmitValidator =
      NonEmptyStringValidator();

  bool canSubmitName(String name) {
    return nameSubmitValidator.isValid(name);
  }

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    return passwordSubmitValidator.isValid(password);
  }

  bool canSubmitLogInPassword(String password) {
    return passwordLogInSubmitValidator.isValid(password);
  }

  String? nameErrorText(String name) {
    final bool showErrorText = !canSubmitName(name);
    final String errorText =
        name.isEmpty ? 'Name can\'t be empty' : 'Invalid Name';
    return showErrorText ? errorText : null;
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText =
        email.isEmpty ? 'Email can\'t be empty' : 'Invalid email';
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !canSubmitPassword(password);
    final String errorText =
        password.isEmpty ? 'Password can\'t be empty' : 'Password is too short';
    return showErrorText ? errorText : null;
  }

  String? passwordLogInErrorText(String password) {
    final bool showErrorText = !canSubmitLogInPassword(password);
    const String errorText = 'Password can\'t be empty';
    return showErrorText ? errorText : null;
  }
}
