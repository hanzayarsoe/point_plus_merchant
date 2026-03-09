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
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isDense;

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
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
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
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            hintText: hintText,
            counterText: '',
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: isDense ?? false,
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
