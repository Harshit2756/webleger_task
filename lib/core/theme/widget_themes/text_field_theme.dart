import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import '../colors.dart';

class HTextFormFieldTheme {
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: HColors.darkGrey,
    suffixIconColor: HColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: HSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: HSizes.fontSizeMd16, color: HColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: HSizes.fonHSizesm14, color: HColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: HColors.black.withValues(alpha: 0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(HSizes.buttonRadius12),
      borderSide: const BorderSide(width: 1, color: HColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(HSizes.buttonRadius12),
      borderSide: const BorderSide(width: 1, color: HColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(HSizes.buttonRadius12),
      borderSide: const BorderSide(width: 1, color: HColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(HSizes.buttonRadius12),
      borderSide: const BorderSide(width: 1, color: HColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(HSizes.buttonRadius12),
      borderSide: const BorderSide(width: 2, color: HColors.warning),
    ),
  );
  HTextFormFieldTheme._();
}
