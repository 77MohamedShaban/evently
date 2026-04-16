import 'package:evently/core/resources/StringsManager.dart';

abstract class AppValidator {
  static String? emailValidator(String? email) {
    if (email == null || email.trim().isEmpty) {
      return StringsManager.emailRequired;
    }

    final RegExp regex = RegExp(
      r'^(?!.*\.\.)'
      r'[a-zA-Z0-9._%+-]+'
      r'@[a-zA-Z0-9.-]+'
      r'\.[a-zA-Z]{2,}$',
    );

    if (!regex.hasMatch(email)) {
      return StringsManager.invalidEmail;
    }

    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.trim().isEmpty) {
      return StringsManager.nameRequired;
    }

    if (name.length < 3) {
      return StringsManager.nameAtLeast;
    }

    return null;
  }

  // Validate password using regex
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return StringsManager.passwordRequired;
    }

    if (value.length < 8) {
      return StringsManager.passwordAtLeast;
    }

    // Password regex pattern (at least one uppercase, one lowercase, one number)
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?.]).{8,}$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return StringsManager.passwordInvalid;
    }

    return null;
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return StringsManager.confirmPasswordRequired;
    }
    if (value != password) {
      return StringsManager.passwordNotMatch;
    }
    return null;
  }

  static String? eventTitleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringsManager.enterEventTitle;
    }
    if (value.length < 5) {
      return StringsManager.titleAtLeast;
    }
    return null;
  }

  static String? eventDescriptionValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringsManager.enterEventDesc;
    }
    if (value.length < 10) {
      return StringsManager.descAtLeast;
    }
    return null;
  }
}
