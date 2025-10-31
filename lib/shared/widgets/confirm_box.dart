import 'package:flutter/material.dart';
import 'package:merchant/core/constants/enum.dart';

class ConfirmBox extends StatelessWidget {
  final String title, body;
  final String? mainActionText, secondaryActionText;
  final VoidCallback? mainAction, secondaryAction;
  final DialogType? dialogType;
  final double buttonWidth;
  final double buttonHeight;
  const ConfirmBox({
    super.key,
    required this.title,
    required this.body,
    this.mainActionText,
    this.secondaryActionText,
    this.mainAction,
    this.secondaryAction,
    this.dialogType,
    this.buttonWidth = 150.0,
    this.buttonHeight = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Text(
        body,
        style: Theme.of(context).textTheme.bodyLarge,
        softWrap: true,
        textAlign: TextAlign.start,
      ),
      actions: [
        if (secondaryActionText != null && secondaryAction != null)
          ElevatedButton(
            onPressed: secondaryAction,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(buttonWidth, buttonHeight),
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.inverseSurface,
              side: BorderSide(
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            child: Text(
              secondaryActionText!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        if (mainActionText != null && mainAction != null)
          ElevatedButton(
            onPressed: mainAction,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150, 40),
              backgroundColor:
                  dialogType != null && dialogType == DialogType.confirm
                  ? Theme.of(context).colorScheme.primary
                  : dialogType == DialogType.delete
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
              foregroundColor:
                  dialogType != null && dialogType == DialogType.delete
                  ? Theme.of(context).colorScheme.inverseSurface
                  : Theme.of(context).colorScheme.surface,
            ),
            child: Text(
              mainActionText!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: dialogType != null && dialogType == DialogType.delete
                    ? Theme.of(context).colorScheme.inverseSurface
                    : Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
