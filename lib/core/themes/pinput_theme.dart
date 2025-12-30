import 'package:flutter/material.dart';
import 'package:merchant/core/themes/dark_theme.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(
    fontFamily: "Walone",
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(10),
  ),
);

final focusedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(
    border: Border.all(color: DarkTheme.primaryColor),
  ),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(
    border: Border.all(color: DarkTheme.primaryColor),
  ),
);
