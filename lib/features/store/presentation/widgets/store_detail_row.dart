import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class StoreDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const StoreDetailRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.onSurface),
        SizedBox(width: AppSpacing.smallSpacing),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
