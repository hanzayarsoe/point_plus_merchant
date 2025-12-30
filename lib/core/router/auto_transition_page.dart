import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page<dynamic> autoTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  final path = state.matchedLocation;
  if (path.contains('/scanner') ||
      path.contains('/search-account') ||
      path.contains('/point-transfer') ||
      path.contains('/withdraw') ||
      path.contains('/verify-otp') ||
      path.contains('/recharge')) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: child,
      fullscreenDialog: true,
    );
  }
  return MaterialPage<void>(key: state.pageKey, child: child);
}
