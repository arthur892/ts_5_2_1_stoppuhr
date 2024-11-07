class TimerValidator {
  static bool validInput(String value) {
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasDigits = value.contains(RegExp(r'[0-9]'));
    bool hasLowercase = value.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return !hasUppercase & hasDigits & !hasLowercase & !hasSpecialCharacters;
  }
}
