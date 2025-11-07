import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/shared/widgets/confirm_box.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmBox(
              dialogType: DialogType.delete,
              title: '',
              body: '',
              mainActionText: '',
              mainAction: () {
                context.pop();
              },
              secondaryActionText: '',
              secondaryAction: () => context.pop(),
            );
          },
        );
      },
      child: Align(
        child: Text(
          '',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
