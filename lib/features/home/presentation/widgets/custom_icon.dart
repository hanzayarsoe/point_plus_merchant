import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final Icon icon;
  final EdgeInsets padding;
  final Color paddingColor;
  final VoidCallback? onPressed;
  final String? svgIcon;
  final List<Color>? linearGradientColor;
  const CustomIcon({
    super.key,
    required this.icon,
    required this.padding,
    this.onPressed,
    required this.paddingColor,
    this.svgIcon,
    this.linearGradientColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: paddingColor,
          shape: BoxShape.circle,
          gradient: linearGradientColor != null
              ? LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: linearGradientColor!,
                )
              : null,
        ),
        child: svgIcon != null ? SvgPicture.asset(svgIcon!) : icon,
      ),
    );
  }
}
