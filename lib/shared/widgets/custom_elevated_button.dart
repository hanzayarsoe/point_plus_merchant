import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isDisabled;
  final ButtonStyle? buttonStyle;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isDisabled,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: buttonStyle,
      child: Text(text),
    );
  }
}
