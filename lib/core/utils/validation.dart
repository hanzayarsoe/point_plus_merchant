import 'package:merchant/core/constants/app_constants.dart';

class AppValidator {
  String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  String? validateNewEmail(String? value, String oldEmail) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    if (value.trim() == oldEmail.trim()) {
      return 'old email and new email must not be same';
    }

    return null;
  }

  String? validatePassword(String? field, String? value) {
    if (value == null || value.isEmpty) {
      return '$field is required';
    }
    return null;
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'phone number must not be empty';
    }

    final phoneRegExp = RegExp(r'^\d{9,11}$'); // ✅ 9-11 digits only

    if (!phoneRegExp.hasMatch(value)) {
      return 'invalid phone number (9-11 digits required)';
    }

    return null;
  }

  String? validateAmount(String value) {
    if (value.isEmpty) {
      return 'amount must not be empty';
    }
    if (double.tryParse(value) == null || double.tryParse(value)! <= 0) {
      return 'please enter valid amount';
    }
    return null;
  }

  String? passwordMatch(String newPassowrd, String confirmNewPassowrd) {
    if (confirmNewPassowrd.length < AppConstants.passwordLength) {
      return 'password must be at least 6 digits or characters';
    }
    if (confirmNewPassowrd.isNotEmpty) {
      if (newPassowrd != confirmNewPassowrd) {
        return 'password must be same';
      }
    }
    return null;
  }
}
