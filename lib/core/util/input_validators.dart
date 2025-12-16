class InputValidators {
  /// Validates password — must be at least 8 chars.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  /// Validates an username
  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  /// Validates user input
  static String? validateUserInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty.';
    }
    return null;
  }
}
