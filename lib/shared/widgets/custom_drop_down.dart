import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';

class CustomDropDown extends StatefulWidget {
  final String? titleText;
  final String? hintText;
  final List<DisplayNameEnum> dropDownList;
  final TextEditingController controller;
  final Function(dynamic)? onSelected;
  const CustomDropDown({
    super.key,
    required this.dropDownList,
    required this.controller,
    this.titleText,
    this.hintText,
    this.onSelected,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null) ...[
          Text(widget.titleText!, style: Theme.of(context).textTheme.bodyLarge),
          AppSpacing.extraSmallSizedBox,
        ],
        DropdownMenuFormField(
          width: double.infinity,
          controller: widget.controller,
          hintText: widget.hintText,
          dropdownMenuEntries: widget.dropDownList.map((item) {
            return DropdownMenuEntry(value: item, label: item.displayName);
          }).toList(),
          onSelected: widget.onSelected,
        ),
      ],
    );
  }
}
