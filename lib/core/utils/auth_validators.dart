import 'package:tasky_app/core/constants/reg_expre_form.dart';

class AuthValidators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return "Email is required";
    if (!RegExpreForm.emailRegExp.hasMatch(email)) return 'Enter a valid email';
    return null;
  }

  static String? validateUsername(String? userName) {
    if (userName == null || userName.isEmpty) return 'Username is required';
    if (!RegExpreForm.usernameRegExp.hasMatch(userName)) {
      return 'Only letters, numbers, and underscores (3–20 chars)';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password is required';
    if (!RegExpreForm.passwordRegExp.hasMatch(password)) {
      return 'Password must be at least 8 characters,\ninclude upper, lower, number, and symbol';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
