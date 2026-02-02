import 'package:flutter/material.dart';

class AppColorSchemes {
  static ColorScheme get lightScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00696a),
      surfaceTint: Color(0xFF00696a),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF9cf1f1),
      onPrimaryContainer: Color(0xFF004f50),
      secondary: Color(0xFF4a6363),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFcce8e7),
      onSecondaryContainer: Color(0xFF324b4b),
      // tertiary: Color(0xFF4c5f7c),
      // onTertiary: Color(0xFFFFFFFF),
      // tertiaryContainer: Color(0xFFd3e3ff),
      // onTertiaryContainer: Color(0xFF344863),
      error: Color(0xFFba1a1a),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFffdad6),
      onErrorContainer: Color(0xFF93000a),
      surface: Color(0xFFf4fbfa),
      onSurface: Color(0xFF161d1d),
      onSurfaceVariant: Color(0xFF3f4948),
      outline: Color(0xFF6f7979),
      outlineVariant: Color(0xFFbec8c8),
      //shadow: Color(0xFF000000),
      //scrim: Color(0xFF000000),
      //inverseSurface: Color(0xFF2b3231),
      //inversePrimary: Color(0xFF80d4d5),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFeff5f4),
      surfaceContainer: Color(0xFFe9efee),
      surfaceContainerHigh: Color(0xFFe3e9e9),
      surfaceContainerHighest: Color(0xFFdde4e3),
      //success
      tertiary: Color(0xFF117E2A),
      //on_success
      onTertiary: Color(0xFFFFFFFF),
      //success_container
      tertiaryContainer: Color(0x14117E2A),
      //success_on_container
      onTertiaryContainer: Color(0xFF0A4818),
      //text_field_disabled
      shadow: Color(0xFF72767A),
      //disabled_outline
      scrim: Color(0xFFCAD2D9),
      //warning
      inverseSurface: Color(0xFFF97316),
      //on_warning
      onInverseSurface: Color(0xFF3C1A01),
      //warning_container
      inversePrimary: Color(0xFFFEF3EB),
      tertiaryFixed: Color(0xFF5B7FFF),
    );
  }

  static ColorScheme get darkScheme {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF80d4d5),
      surfaceTint: Color(0xFF80d4d5),
      onPrimary: Color(0xFF003737),
      primaryContainer: Color(0xFF004f50),
      onPrimaryContainer: Color(0xFF9cf1f1),
      secondary: Color(0xFFb0cccb),
      onSecondary: Color(0xFF1b3435),
      secondaryContainer: Color(0xFF324b4b),
      onSecondaryContainer: Color(0xFFcce8e7),
      // tertiary: Color(0xFFb3c8e9),
      // onTertiary: Color(0xFF1d314b),
      // tertiaryContainer: Color(0xFF344863),
      // onTertiaryContainer: Color(0xFFd3e3ff),
      error: Color(0xFFffb4ab),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000a),
      onErrorContainer: Color(0xFFffdad6),
      surface: Color(0xFF0e1514),
      onSurface: Color(0xFFdde4e3),
      onSurfaceVariant: Color(0xFFbec8c8),
      outline: Color(0xFF899392),
      outlineVariant: Color(0xFF3f4948),
      // shadow: Color(0xFF000000),
      //scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFdde4e3),
      inversePrimary: Color(0xFF00696a),
      surfaceContainerLowest: Color(0xFF090f0f),
      surfaceContainerLow: Color(0xFF161d1d),
      surfaceContainer: Color(0xFF1a2121),
      surfaceContainerHigh: Color(0xFF252b2b),
      surfaceContainerHighest: Color(0xFF2f3636),
      //success
      tertiary: Color(0xFF117E2A),
      //on_success
      onTertiary: Color(0xFFFFFFFF),
      //success_container
      tertiaryContainer: Color(0x14117E2A),
      //success_on_container
      onTertiaryContainer: Color(0xFF0A4818),
      //text_field_disabled
      shadow: Color(0xFF9D9D9D),
      //disabled_outline
      scrim: Color(0xFF343434),
      //warning
      //inverseSurface: Color(0xFFF97316),
      //on_warning
      onInverseSurface: Color(0xFF3C1A01),
      //warning_container
      //inversePrimary: Color(0xFF3C1A01),
      tertiaryFixed: Color(0xFF5B7FFF),
    );
  }
}

const kLightSurfaceColor = Color(0xFF5A6F81);

const kDarkSurfaceColor = Color(0xFF22292F);

const kLightNeutralColor = Color(0xFFF0F2F6);

const kDisableButton = Color(0xFFBCCCDC);
const kLightGrey = Color(0xFFDBE1E5);

const kDarkBlue = Color(0xff0B72EB);

const kDebitColor = Color(0xffD41717);
const kCreditColor = Color(0xff117E2A);

const kShadow = Color(0xff001A49);
const kSuccess = Color(0xff117E2A);
