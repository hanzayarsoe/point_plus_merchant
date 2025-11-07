import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? titleText;
  final TextEditingController controller;
  final TextInputType? inputType;
  final List<TextInputFormatter>? textInputFormatters;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? errorText;
  final bool? readOnly;
  final bool? enabled;
  final Function()? onTap;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.titleText,
    required this.controller,
    this.inputType,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.focusNode,
    this.textInputFormatters,
    this.errorText,
    this.readOnly,
    this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null) ...[
          Text(titleText!, style: Theme.of(context).textTheme.bodyLarge),
          AppSpacing.extraSmallSizedBox,
        ],
        TextFormField(
          enabled: enabled,
          controller: controller,
          keyboardType: inputType,
          inputFormatters: textInputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            errorText: errorText,
          ),
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          maxLength: maxLength,
          focusNode: focusNode,
          readOnly: readOnly ?? false,
        ),
      ],
    );
  }
}
