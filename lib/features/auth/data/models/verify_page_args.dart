import 'package:flutter/material.dart';

class VerifyPageArgs {
  final String phoneNumber;
  final VoidCallback onSuccess;
  final VoidCallback onFailed;
  final String apiRoute;
  final String apiMethod;
  VerifyPageArgs({
    required this.phoneNumber,
    required this.onSuccess,
    required this.onFailed,
    required this.apiRoute,
    required this.apiMethod,
  });
}
