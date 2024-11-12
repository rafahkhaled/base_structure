import 'package:base_structure/core/singletons/localized_keys.dart';
import 'package:base_structure/core/utils.dart';
import 'package:get/get.dart';

class ValidationHelper {
  static String? validateEmail(String? value, {List<String>? msgs}) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return Utils.parseLocalizedKey(LocalizedKeys.Email_Required);
    } else if (!regex.hasMatch(value)) {
      return Utils.parseLocalizedKey(LocalizedKeys.Email_Invalid);
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

    if (value == null || value.isEmpty) {
      return Utils.parseLocalizedKey(LocalizedKeys.Phone_Required.tr.trArgs());
    } else if (!phoneRegex.hasMatch(value)) {
      return Utils.parseLocalizedKey(LocalizedKeys.Phone_Invalid);
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return Utils.parseLocalizedKey(LocalizedKeys.Password_Required);
    } else if (value.length < 8) {
      return Utils.parseLocalizedKey(LocalizedKeys.Password_Length);
    }
    return null;
  }

  static String? validateName(String? value) {
    final nameRegex = RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)*$');

    if (value == null || value.isEmpty) {
      return Utils.parseLocalizedKey(LocalizedKeys.Name_Required);
    } else if (value.length < 2) {
      return Utils.parseLocalizedKey(LocalizedKeys.Name_Length);
    } else if (!nameRegex.hasMatch(value)) {
      return Utils.parseLocalizedKey(LocalizedKeys.Name_Invalid);
    }
    return null;
  }

  static String? validateMedicineValues(String? value, String localizedLabel) {
    if (value == null || value.isEmpty) {
      return Utils.parseLocalizedKey(LocalizedKeys.Medicine_Required,
          templatedValues: [Utils.parseLocalizedKey(localizedLabel)]);
    } else if (value.length < 2) {
      return Utils.parseLocalizedKey(LocalizedKeys.Medicine_Length,
          templatedValues: [Utils.parseLocalizedKey(localizedLabel)]);
    }
    return null;
  }

  static String? validateNum(String? value, String label) {
    if (value == null || value.isEmpty) {
      return Utils.parseLocalizedKey(LocalizedKeys.Num_Required,
          templatedValues: [Utils.parseLocalizedKey(label)]);
    } else if (!Utils.isNumber(value)) {
      return Utils.parseLocalizedKey(LocalizedKeys.Num_Invalid,
          templatedValues: [Utils.parseLocalizedKey(label)]);
    }
    return null;
  }
}
