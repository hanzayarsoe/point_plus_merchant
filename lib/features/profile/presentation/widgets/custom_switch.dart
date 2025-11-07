import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool? value;
  final Function(bool) onChanged;
  const CustomSwitch({super.key, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Transform.scale(
        scale: 0.8,
        child: Switch(
          padding: EdgeInsets.zero,
          value: value ?? false,
          onChanged: onChanged,
          thumbColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.inverseSurface;
            }
            return Theme.of(context).colorScheme.primary;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return Theme.of(context).colorScheme.primary;
            }
            return Theme.of(context).colorScheme.inverseSurface;
          }),
        ),
      ),
    );
  }
}
