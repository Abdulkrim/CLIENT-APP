import 'package:flutter/cupertino.dart';

import '../../../injection.dart';
import '../configuration.dart';

abstract class Validation<T> {
  String? validate(BuildContext context, T? value);
}

class EmailValidation extends Validation<String> {
  @override
  String? validate(BuildContext context, String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return switch (value) {
      (String value) when !emailRegex.hasMatch(value) => 'Please enter a valid email',
      (String? value) when value == null => null,
      _ => null,
    };
  }
}

class DomainValidation extends Validation<String> {
  @override
  String? validate(BuildContext context, String? value) {
    final domainRegex = RegExp("^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\\.)+[A-Za-z]{2,6}");

    return switch (value) {
      (String value) when !domainRegex.hasMatch('$value.${getIt<Configuration>().branchUrl}') =>
        'Should be a-z or A-Z or 0-9 and hyphen (-)\nShould be between 1 and 63 characters long.\nShould not start or end with a hyphen',
      (String? value) when value == null => null,
      _ => null,
    };
  }
}

class PasswordValidation extends Validation<String> {
  @override
  String? validate(BuildContext context, String? value) {
    RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

    return switch (value) {
      (String value) when !passwordRegex.hasMatch('$value.${getIt<Configuration>().branchUrl}') =>
        'Passwords must be at least 8 characters,\none digit 0..9,and one uppercase A..Z ',
      (String? value) when value == null => null,
      _ => null,
    };
  }
}

class PhoneNumberValidation extends Validation<String> {
  @override
  String? validate(BuildContext context, String? value) {
    RegExp phoneRegex = RegExp(r'^\d{9,12}$');

    return switch (value) {
      (String value) when !phoneRegex.hasMatch(value) => 'Please enter a valid Phone Number ',
      (String? value) when value == null => null,
      _ => null,
    };
  }
}

class BusinessNameValidation extends Validation<String> {
  @override
  String? validate(BuildContext context, String? value) {
    RegExp businessNameRegex = RegExp(r"^[^\!@#\$%\^*\(\)]{4,}$");

    return switch (value) {
      (String value) when !businessNameRegex.hasMatch(value) =>
        'The name must be more than 4 characters\nThe name must not contain the characters !@#\\\$%^*()',
      (String? value) when value == null => null,
      _ => null,
    };
  }
}
