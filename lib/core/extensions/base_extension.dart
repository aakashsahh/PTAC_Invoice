import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AppLocalizationsX on BuildContext {
  // AppLocalizations get l10n => AppLocalizations.of(this);
}

extension BuildContextExtensions on BuildContext {
  // TextTheme get textTheme => theme.textTheme;

  // ColorScheme get colorScheme => theme.colorScheme;

  // UserSimplePreferences get userSimplePref =>
  //     Provider.of<UserSimplePreferences>(this);
}

extension StringToIntExtension on String? {
  int? toIntOrNull() {
    try {
      return int.parse(this ?? '');
    } catch (e) {
      return null;
    }
  }

  int toIntOrZero() {
    return toIntOrNull() ?? 0;
  }

  double? toDoubleOrNull() {
    try {
      return double.parse(this ?? '');
    } catch (e) {
      return null;
    }
  }

  double toDoubleOrZero() {
    return toDoubleOrNull() ?? 0.0;
  }
}

extension DateStringFormatter on String? {
  String toFormattedDate({String format = 'yyyy/MM/dd - hh:mm a'}) {
    if (this == null) return '';
    try {
      DateTime dateTime = DateTime.parse(this!);
      DateFormat dateFormat = DateFormat(format);
      return dateFormat.format(dateTime.toLocal());
    } catch (e) {
      return this ?? '';
    }
  }
}

extension BaseExtension on String? {
  String toInitials() {
    if (this == null) return '';

    try {
      List<String> words = this!.trim().split(' ');
      if (words.length >= 2) {
        return words.first[0].toUpperCase() + words.last[0].toUpperCase();
      } else if (words.isNotEmpty) {
        return words.first[0].toUpperCase();
      }
    } catch (e) {
      return '';
    }
    return ''; // Fallback for empty input
  }
}

extension FormattedPrice on String? {
  String toFormattedPrice() {
    if (this == null || this == 'null') return '-';

    try {
      double value = double.parse(this!);
      NumberFormat formatter = NumberFormat('#,##,##0.00');
      return 'Rs. ${formatter.format(value)}';
    } catch (e) {
      return this ?? '';
    }
  }

  String toFormattedPriceAmount() {
    if (this == null || this == 'null') return '-';

    try {
      double value = double.parse(this!);
      NumberFormat formatter = NumberFormat('#.00');
      return formatter.format(value);
    } catch (e) {
      return this ?? '';
    }
  }
}

extension Validation on String? {
  bool isValidEmail() {
    if (this == null) return false;
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this!);
  }

  bool isValidMobileNumber() {
    if (this == null) return false;
    return this?.startsWith('9') == true && this?.length == 10;
  }
}

// extension ClearSelected on List<BaseModel>? {
//   void clearSelected() {
//     if (this == null) return;
//     for (var element in this!) {
//       element.checked = false;
//     }
//   }
// }

extension Date on DateTime {
  String getFormatedDateString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
