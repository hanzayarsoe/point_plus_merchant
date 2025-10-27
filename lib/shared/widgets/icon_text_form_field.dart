import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class IconTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final VoidCallback? suffixIconPreesed;
  final bool? isObsurce;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatter;

  const IconTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.errorText,
    this.prefixIcon,
    this.suffixIconPreesed,
    this.isObsurce,
    this.borderColor,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObsurce ?? false,
      obscuringCharacter: '*',
      inputFormatters: inputFormatter,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        counterText: '',
        errorText: errorText,
        prefixIcon: prefixIcon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: AppSpacing.defaultSpacing),
                  Icon(prefixIcon, size: 24),
                  SizedBox(width: AppSpacing.defaultSpacing),
                  Container(width: 0.3, height: 40, color: Colors.white),
                  SizedBox(width: AppSpacing.defaultSpacing),
                ],
              )
            : null,
        suffixIcon: IconButton(
          onPressed: suffixIconPreesed,
          icon: Icon(suffixIcon, size: 24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}
