import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:merchant/core/constants/app_assets.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(200),
              child: Center(child: LottieBuilder.asset(AppAssets.loading)),
            ),
          ),
      ],
    );
  }
}
