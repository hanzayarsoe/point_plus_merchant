import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/history/presentation/cubit/cubit/history_filter_cubit.dart';
import 'package:merchant/features/history/presentation/widgets/custom_date_chip.dart';
import 'package:merchant/features/home/presentation/cubits/request_filter_cubit/cubit/request_filter_cubit.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';

class CustomBottomSheet extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final int initialChipIndex;
  final bool isHistoryFilter;
  const CustomBottomSheet({
    super.key,
    this.startDate,
    this.endDate,
    required this.isHistoryFilter,
    required this.initialChipIndex,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int selectedIndexChip = -1;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  ActiveDateField _activeDateField = ActiveDateField.start;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final FocusNode _startDateFocusNode = FocusNode();
  final FocusNode _endDateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
    selectedIndexChip = widget.initialChipIndex;

    if (_selectedStartDate != null) {
      _startDateController.text = Formatter.formatDateToHistoryDate(
        _selectedStartDate!,
      );
    }
    if (_selectedEndDate != null) {
      _endDateController.text = Formatter.formatDateToHistoryDate(
        _selectedEndDate!,
      );
    }
    _startDateFocusNode.addListener(() {
      if (_startDateFocusNode.hasFocus) {
        setState(() {
          _activeDateField = ActiveDateField.start;
        });
      }
    });
    _endDateFocusNode.addListener(() {
      if (_endDateFocusNode.hasFocus) {
        setState(() {
          _activeDateField = ActiveDateField.end;
        });
      }
    });
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _startDateFocusNode.dispose();
    _endDateFocusNode.dispose();
    super.dispose();
  }

  void _selectDateTime(int index) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    setState(() {
      switch (index) {
        case 0:
          {
            _selectedStartDate = today.subtract(const Duration(days: 6));
            _selectedEndDate = today;
          }
        case 1:
          {
            _selectedStartDate = today.subtract(const Duration(days: 29));
            _selectedEndDate = today;
          }
        case 2:
          {
            _startDateFocusNode.requestFocus();
          }
      }
      if (_selectedStartDate != null) {
        _startDateController.text = Formatter.formatDateToHistoryDate(
          _selectedStartDate!,
        );
      }
      if (_selectedEndDate != null) {
        _endDateController.text = Formatter.formatDateToHistoryDate(
          _selectedEndDate!,
        );
      }
    });
  }

  void _applyFilters() {
    if (widget.isHistoryFilter) {
      context.read<HistoryFilterCubit>().updateFilters(
        selectedChipIndex: selectedIndexChip,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
      );
    } else {
      context.read<RequestFilterCubit>().updateFilters(
        selectedChipIndex: selectedIndexChip,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
      );
    }
    context.pop();
  }

  void _clearFilters() {
    setState(() {
      selectedIndexChip = -1;
      _selectedStartDate = null;
      _selectedEndDate = null;
      _startDateController.clear();
      _endDateController.clear();
    });
    if (widget.isHistoryFilter) {
      context.read<HistoryFilterCubit>().clearFilters();
    } else {
      context.read<RequestFilterCubit>().clearFilters();
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.defaultPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date Range',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: _clearFilters,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  overlayColor: Colors.transparent,
                ),
                child: Text(
                  'Clear Filter',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            ],
          ),
          AppSpacing.smallSizedBox,
          Row(
            spacing: AppSpacing.smallSpacing,
            children: [
              CustomDateChip(
                label: 'Last 7 days',
                index: 0,
                selectedIndex: selectedIndexChip,
                onSelected: (index) => setState(() {
                  selectedIndexChip = index;
                  _selectDateTime(index);
                }),
              ),
              CustomDateChip(
                label: 'Last 30 days',
                index: 1,
                selectedIndex: selectedIndexChip,
                onSelected: (index) => setState(() {
                  selectedIndexChip = index;
                  _selectDateTime(index);
                }),
              ),
              CustomDateChip(
                label: 'Custom',
                index: 2,
                selectedIndex: selectedIndexChip,
                onSelected: (index) => setState(() {
                  selectedIndexChip = index;
                  _selectDateTime(index);
                }),
              ),
            ],
          ),
          AppSpacing.largeSizedBox,
          CustomTextFormField(
            controller: _startDateController,
            focusNode: _startDateFocusNode,
            prefixIcon: Icon(
              LucideIcons.calendarDays,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            isDense: true,
            readOnly: true,
            onTap: () => _startDateFocusNode.requestFocus(),
          ),
          AppSpacing.smallSizedBox,
          CustomTextFormField(
            controller: _endDateController,
            focusNode: _endDateFocusNode,
            isDense: true,
            readOnly: true,
            prefixIcon: Icon(
              LucideIcons.calendarDays,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onTap: () => _endDateFocusNode.requestFocus(),
          ),
          if (selectedIndexChip == 2)
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.dmy,
                initialDateTime:
                    (_activeDateField == ActiveDateField.start
                        ? _selectedStartDate
                        : _selectedEndDate) ??
                    DateTime.now(),
                onDateTimeChanged: (newDate) {
                  setState(() {
                    if (_activeDateField == ActiveDateField.start) {
                      _startDateController.text =
                          Formatter.formatDateToHistoryDate(newDate);
                      _selectedStartDate = newDate;

                      if (_selectedEndDate != null &&
                          newDate.isAfter(_selectedEndDate!)) {
                        _selectedEndDate = newDate;
                        _endDateController.text =
                            Formatter.formatDateToHistoryDate(newDate);
                      }
                    }
                    if (_activeDateField == ActiveDateField.end) {
                      _endDateController.text =
                          Formatter.formatDateToHistoryDate(newDate);
                      _selectedEndDate = newDate;

                      if (_selectedStartDate != null &&
                          newDate.isBefore(_selectedStartDate!)) {
                        _selectedStartDate = newDate;
                        _startDateController.text =
                            Formatter.formatDateToHistoryDate(newDate);
                      }
                    }
                  });
                },
              ),
            ),
          AppSpacing.smallSizedBox,
          GradientElevatedButton(
            onPressed: _applyFilters,
            text: 'Apply Changes',
            isDisabled: _selectedStartDate == null || _selectedEndDate == null,
          ),
        ],
      ),
    );
  }
}
