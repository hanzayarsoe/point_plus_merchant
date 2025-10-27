import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/features/auth/presentation/widgets/circle_reveal_clipper.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      body:
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Image.asset(AppAssets.appLogo).animate().slideY(
                begin: -5.0,
                end: 0,
                duration: 1800.ms,
                curve: Curves.easeOutBack,
              ),
            ),
          ).animate().custom(
            duration: 500.ms,
            curve: Curves.easeOut,
            builder: (context, value, child) {
              final size = MediaQuery.of(context).size;
              final maxRadius =
                  sqrt(pow(size.width, 2) + pow(size.height, 2)) / 2;
              final radius = value * maxRadius;
              final center = Offset(size.width / 2, size.height / 2);

              return ClipPath(
                clipper: CircleRevealClipper(radius: radius, center: center),
                child: child,
              );
            },
          ),
    );
  }
}
