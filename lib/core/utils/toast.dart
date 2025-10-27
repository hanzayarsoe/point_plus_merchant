import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

void showToast({
  required String message,
  String? title,
  ToastificationType type = ToastificationType.info,
  ToastificationStyle style = ToastificationStyle.flatColored,
  Duration duration = const Duration(seconds: 3),
  Alignment alignment = Alignment.topCenter,
}) {
  toastification.show(
    type: type,
    style: style,
    autoCloseDuration: duration,
    title: title != null ? Text(title) : null,
    description: Text(message),
    alignment: alignment,
  );
}
