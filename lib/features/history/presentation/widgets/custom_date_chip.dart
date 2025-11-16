import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class CustomDateChip extends StatelessWidget {
  final Function(int) onSelected;
  final String label;
  final int index;
  final int selectedIndex;
  const CustomDateChip({
    super.key,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = (selectedIndex == index);
    return GestureDetector(
      onTap: () => onSelected(index),
      child: Container(
        padding: AppSpacing.smallPadding,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
          borderRadius: AppSpacing.bigBorderRadiusCircular,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: isSelected ? Theme.of(context).colorScheme.surface : null,
          ),
        ),
      ),
    );
  }
}
