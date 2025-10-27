import 'package:flutter/material.dart';
import 'package:merchant/core/themes/pinput_theme.dart';
import 'package:pinput/pinput.dart';

class CustomPinPutField extends StatelessWidget {
  final String? titleText;
  final int length;
  final bool isObsurce;
  final TextEditingController pinController;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  const CustomPinPutField({
    super.key,
    this.titleText,
    required this.pinController,
    required this.length,
    required this.isObsurce,
    this.onChanged,
    this.onCompleted,
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null)
          Text(
            titleText!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
        Pinput(
          keyboardType: TextInputType.number,
          controller: pinController,
          defaultPinTheme: defaultPinTheme,
          length: length,
          errorText: errorText,
          forceErrorState: errorText != null,
          errorTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
          validator: validator,
          obscureText: isObsurce,
          obscuringWidget: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          onChanged: onChanged,
          onCompleted: onCompleted,
        ),
      ],
    );
  }
}
