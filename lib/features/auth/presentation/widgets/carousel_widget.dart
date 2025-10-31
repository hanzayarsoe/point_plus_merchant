import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class CarouselWidget extends StatelessWidget {
  final String image, title, body;
  const CarouselWidget({
    super.key,
    required this.image,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.2),
            child: Image.asset(image),
          ),
        ).animate().fade(delay: 900.ms, duration: 1000.ms),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.defaultSpacing),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ).animate().fade(delay: 1000.ms, duration: 1000.ms),
      ],
    );
  }
}
