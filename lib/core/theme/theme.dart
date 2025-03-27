import 'package:flutter/material.dart';

import 'colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/chip_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class HAppTheme {
  HAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: HColors.primary,
      secondary: HColors.secondary,
    ),
    disabledColor: HColors.grey,
    brightness: Brightness.light,
    primaryColor: HColors.primary,
    textTheme: HTextTheme.lightTextTheme,
    scaffoldBackgroundColor: HColors.grey,
    appBarTheme: HAppBarTheme.lightAppBarTheme,
    chipTheme: HChipTheme.lightChipTheme,
    elevatedButtonTheme: HElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: HTextFormFieldTheme.lightInputDecorationTheme,
  );
}
