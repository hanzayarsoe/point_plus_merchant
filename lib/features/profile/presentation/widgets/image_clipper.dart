import 'package:flutter/material.dart';

class InwardBottomClipper extends CustomClipper<Path> {
  final double bottomCurveHeight;

  InwardBottomClipper({this.bottomCurveHeight = 20.0});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at top-left
    path.moveTo(0, 0);

    // Top edge (normal, straight line)
    path.lineTo(size.width, 0);

    // Right edge, stopping before the bottom curve
    path.lineTo(size.width, size.height - bottomCurveHeight);

    // Bottom-right corner (inward curve)
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - bottomCurveHeight,
      size.height,
    );

    // Bottom edge
    path.lineTo(bottomCurveHeight, size.height);

    // Bottom-left corner (inward curve)
    path.quadraticBezierTo(0, size.height, 0, size.height - bottomCurveHeight);

    // Left edge (back to the start)
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
