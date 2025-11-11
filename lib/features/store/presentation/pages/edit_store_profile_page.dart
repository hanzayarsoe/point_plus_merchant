import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/profile/presentation/bloc/bloc/branch_bloc.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:merchant/shared/widgets/show_success_toast.dart';
import 'package:toastification/toastification.dart';

class EditStoreProfilePage extends StatefulWidget {
  const EditStoreProfilePage({super.key});

  @override
  State<EditStoreProfilePage> createState() => _EditStoreProfilePageState();
}

class _EditStoreProfilePageState extends State<EditStoreProfilePage> {
  final TextEditingController _nameContoller = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _primaryPhoneController = TextEditingController();
  final TextEditingController _secondaryPhoneController =
      TextEditingController();
  final TextEditingController _openTimeController = TextEditingController();
  final TextEditingController _closeTimeController = TextEditingController();
  late Branch? _branch;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void _changeBranchInfo() {
    if (_branch != null) {
      final updatedBranch = _branch!.copyWith(
        name: _nameContoller.text,
        branchAddress: _addressController.text,
        secondaryPhoneNumber: _secondaryPhoneController.text,
        openTime: _openTimeController.text,
        closeTime: _closeTimeController.text,
      );
      context.read<BranchBloc>().add(
        BranchEvent.updateBranchInfo(updatedBranch),
      );
    }
  }

  Future<void> _showTimePicker({required bool isOPenTime}) async {
    final String currentTimeString = isOPenTime
        ? _openTimeController.text
        : _closeTimeController.text;
    final DateTime initialTime = Formatter.parseTime(currentTimeString);

    DateTime newSelectedTime = initialTime;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 400,
            padding: AppSpacing.defaultPadding,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: initialTime,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (newTime) {
                      // 3. Update the TEMPORARY variable, not the controller
                      newSelectedTime = newTime;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // 4. User clicked "Done". Now, format and save the time.
                    final String formattedTime =
                        Formatter.formateDateTimeToAmPm(newSelectedTime);
                    setState(() {
                      if (isOPenTime) {
                        _openTimeController.text = formattedTime;
                      } else {
                        _closeTimeController.text = formattedTime;
                      }
                    });
                    _changeButtonState();
                    context.pop();
                  },
                  child: Text(
                    'Done',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changeButtonState() {
    setState(() {
      _isButtonDisabled =
          _nameContoller.text == _branch?.name &&
          _addressController.text == _branch?.branchAddress &&
          _secondaryPhoneController.text == _branch?.secondaryPhoneNumber &&
          _openTimeController.text == _branch?.openTime &&
          _closeTimeController.text == _branch?.closeTime;
    });
  }

  void getData() {
    final branchState = context.read<BranchBloc>().state;
    final branch = branchState.whenOrNull(loadedBranch: (branch) => branch);
    if (branch != null) {
      _nameContoller.text = branch.name;
      _addressController.text = branch.branchAddress;
      _primaryPhoneController.text = branch.primaryPhoneNumber ?? '';
      _secondaryPhoneController.text = branch.secondaryPhoneNumber ?? '';
      _openTimeController.text = branch.openTime ?? '';
      _closeTimeController.text = branch.closeTime ?? '';
      setState(() {
        _branch = branch;
      });
    }
  }

  @override
  void dispose() {
    _nameContoller.dispose();
    _addressController.dispose();
    _primaryPhoneController.dispose();
    _secondaryPhoneController.dispose();
    _openTimeController.dispose();
    _closeTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final branchState = context.watch<BranchBloc>().state;
    final branch = branchState.whenOrNull(loadedBranch: (branch) => branch);
    return BlocConsumer<BranchBloc, BranchState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        updateBranchFailed: (failure) => true,
        updateBranchSuccessed: (updatedBranch) => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          updateBranchFailed: (failure) => showToast(
            message: failure.message,
            type: ToastificationType.error,
          ),
          updateBranchSuccessed: (updatedBranch) async {
            showSuccessToast(context, 'Successfully changed!');
            context.read<AuthBloc>().add(
              AuthEvent.updateBranchInfo(updatedBranch),
            );
            context.read<BranchBloc>().add(BranchEvent.refreshBranchData());
            await Future.delayed(const Duration(seconds: 2));
            if (!context.mounted) return;
            context.pop();
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Edit Profile Screen',
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: AppSpacing.smallCircularBorderRadius,
                    child: Image.asset(
                      AppAssets.mapImage,
                      width: double.infinity,
                      height: 246,
                      fit: BoxFit.cover,
                    ),
                  ),
                  AppSpacing.megaLargeSizedBox,
                  Text(
                    'Profile Picture',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.largeSizedBox,
                  Center(
                    child: ClipRRect(
                      borderRadius: AppSpacing.normalBorderRadiusCircular,
                      child: CustomCachedNetworkImage(
                        profileUrl: branch?.profileUrl,
                        width: 200,
                        height: 200,
                        isProfile: false,
                      ),
                    ),
                  ),
                  AppSpacing.largeSizedBox,
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.smallSizedBox,
                  CustomTextFormField(
                    controller: _nameContoller,
                    titleText: 'Name',
                    onChanged: (_) => _changeButtonState(),
                  ),
                  AppSpacing.smallSizedBox,
                  CustomTextFormField(
                    controller: _addressController,
                    titleText: 'Location',
                    onChanged: (_) => _changeButtonState(),
                  ),
                  AppSpacing.smallSizedBox,
                  CustomTextFormField(
                    readOnly: true,
                    controller: _primaryPhoneController,
                    titleText: 'Mobile Phone',
                  ),
                  AppSpacing.smallSizedBox,
                  CustomTextFormField(
                    controller: _secondaryPhoneController,
                    titleText: 'Secondary Phone',
                    onChanged: (_) => _changeButtonState(),
                  ),
                  AppSpacing.smallSizedBox,
                  CustomTextFormField(
                    readOnly: true,
                    controller: _openTimeController,
                    titleText: 'Open Time',
                    onTap: () async {
                      await _showTimePicker(isOPenTime: true);
                    },
                  ),
                  AppSpacing.smallSizedBox,
                  CustomTextFormField(
                    readOnly: true,
                    controller: _closeTimeController,
                    titleText: 'Close Time',
                    onTap: () async {
                      await _showTimePicker(isOPenTime: false);
                    },
                  ),
                  AppSpacing.megaLargeSizedBox,
                  Text(
                    'About Us',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.largeSizedBox,
                  Text(
                    branch?.about ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  AppSpacing.megaLargeSizedBox,
                  GradientElevatedButton(
                    onPressed: _changeBranchInfo,
                    text: 'Save Changes',
                    isDisabled: _isButtonDisabled,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
