import 'package:flutter/material.dart';

class CircleRevealClipper extends CustomClipper<Path> {
  final double radius;
  final Offset center;

  CircleRevealClipper({required this.radius, required this.center});

  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(covariant CircleRevealClipper oldClipper) {
    return oldClipper.radius != radius || oldClipper.center != center;
  }
}
