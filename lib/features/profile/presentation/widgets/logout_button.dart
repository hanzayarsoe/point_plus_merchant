import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LogOutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LogOutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 0.8,
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      iconAlignment: IconAlignment.end,
      onPressed: onPressed,
      label: Text('Log Out'),
      icon: Icon(LucideIcons.logOut),
    );
  }
}
