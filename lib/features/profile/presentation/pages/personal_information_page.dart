import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/features/profile/presentation/bloc/branch_bloc/branch_bloc.dart';
import 'package:merchant/features/profile/presentation/widgets/delete_account_button.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';
import 'package:merchant/shared/widgets/custom_drop_down.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nrcController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emialController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _pickedImage;
  Manager? _initialManager;
  bool _isChanged = false;

  void _initControllers(Manager manager) {
    _initialManager = manager;
    _nameController.text = manager.name;
    _nrcController.text = Formatter.formatNrcToString(manager.nrc);
    _mobileController.text = manager.phoneNumber ?? '';
    _emialController.text = manager.email ?? '';
    _genderController.text = manager.gender ?? '';
    _dobController.text = Formatter.formatStringToDateOfBirth(
      manager.dob ?? '',
    );
    _addressController.text = manager.address ?? '';

    _nameController.addListener(_checkForChanges);
    _mobileController.addListener(_checkForChanges);
    _emialController.addListener(_checkForChanges);
    _genderController.addListener(_checkForChanges);
    _addressController.addListener(_checkForChanges);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      _checkForChanges();
    }
  }

  Future<void> _showDatePicker() async {
    final today = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(today.year - 100, today.month, today.day),
      lastDate: today,
    );
    if (date != null) {
      setState(() {
        _dobController.text = Formatter.formatDateOfBirth(date);
      });
      _checkForChanges();
    }
  }

  void _checkForChanges() {
    if (_initialManager == null) {
      debugPrint('_checkForChanges: _initialManager is null');
      return;
    }

    final currentDob = _dobController.text;
    final initialDob = _initialManager!.dob != null
        ? Formatter.formatStringToDateOfBirth(_initialManager!.dob!)
        : '';

    final hasChanges =
        _nameController.text != _initialManager!.name ||
        _mobileController.text != (_initialManager!.phoneNumber ?? '') ||
        _emialController.text != (_initialManager!.email ?? '') ||
        _genderController.text != (_initialManager!.gender ?? '') ||
        currentDob != initialDob ||
        _addressController.text != (_initialManager!.address ?? '') ||
        _pickedImage != null;

    debugPrint('Has changes: $hasChanges');

    if (_isChanged != hasChanges) {
      setState(() {
        _isChanged = hasChanges;
      });
    }
  }

  void _updateInfo() {
    if (!_formKey.currentState!.validate()) return;
    if (_initialManager == null) return;

    final dobDate = DateFormat('d MMMM yyyy').parse(_dobController.text);
    final formattedDob = DateFormat('yyyy-MM-dd').format(dobDate);

    final updatedManager = _initialManager!.copyWith(
      name: _nameController.text,
      phoneNumber: _mobileController.text,
      email: _emialController.text,
      gender: _genderController.text,
      dob: formattedDob,
      address: _addressController.text,
      profileUrl: _pickedImage?.path ?? _initialManager!.profileUrl,
    );

    context.read<BranchBloc>().add(
      BranchEvent.updateManagerInfo(updatedManager),
    );
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final user = authState.whenOrNull(authenticated: (user) => user);
    if (user != null) {
      _initControllers(user.manager);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nrcController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _genderController.dispose();
    _emialController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final user = authState.whenOrNull(authenticated: (user) => user);

    if (_initialManager == null && user != null) {
      _initControllers(user.manager);
    }

    return BlocConsumer<BranchBloc, BranchState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        updateBranchFailed: (failure) => true,
        updateBranchSuccessed: (updatedUser) => true,
        updatedManagerSuccessful: () => true,
        updatedManagerFailed: (failure) => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          updatedManagerSuccessful: () {
            FocusScope.of(context).unfocus();
            toastification.show(
              context: context,
              type: ToastificationType.success,
              style: ToastificationStyle.fillColored,
              title: const Text('Success'),
              description: const Text('Profile updated successfully'),
              alignment: Alignment.bottomCenter,
              autoCloseDuration: const Duration(seconds: 3),
            );
            context.read<AuthBloc>().add(const AuthEvent.refreshUser());
            context.read<BranchBloc>().add(
              const BranchEvent.refreshBranchData(),
            );

            setState(() {
              _isChanged = false;
              _pickedImage = null;
            });
          },
          updatedManagerFailed: (failure) {
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.fillColored,
              title: const Text('Error'),
              description: Text(failure.message),
              alignment: Alignment.bottomCenter,
              autoCloseDuration: const Duration(seconds: 3),
            );
          },
        );
      },
      builder: (context, state) {
        final isUserLoading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        final isAuthLoading = authState.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        final isLoading = isUserLoading || isAuthLoading;
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Personal Information',
              automaticallyImplyLeading: true,
              actions: [
                TextButton(
                  onPressed: _isChanged ? _updateInfo : null,
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: _isChanged
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(100),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          _pickedImage != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_pickedImage!),
                                )
                              : ClipOval(
                                  child: CustomCachedNetworkImage(
                                    profileUrl: user?.manager.profileUrl,
                                    width: 100,
                                    height: 100,
                                    isProfile: true,
                                  ),
                                ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () async {
                                _pickImage();
                              },
                              child: CustomIcon(
                                icon: Icon(
                                  LucideIcons.camera,
                                  size: 24,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHigh,
                                ),
                                padding: AppSpacing.extraSmallPadding,
                                paddingColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.largeSizedBox,
                    CustomTextFormField(
                      controller: _nameController,
                      titleText: 'Name',
                      validator: (value) =>
                          sl<AppValidator>().validateEmptyText('name', value),
                    ),
                    AppSpacing.smallSizedBox,
                    CustomTextFormField(
                      controller: _nrcController,
                      titleText: 'NRC',
                      enabled: false,
                    ),
                    AppSpacing.smallSizedBox,
                    CustomTextFormField(
                      controller: _mobileController,
                      titleText: 'Mobile',
                      validator: (value) =>
                          sl<AppValidator>().validateEmptyText('mobile', value),
                    ),
                    AppSpacing.smallSizedBox,
                    CustomTextFormField(
                      controller: _emialController,
                      titleText: 'Email',
                      validator: (value) =>
                          sl<AppValidator>().validateEmptyText('email', value),
                    ),
                    AppSpacing.smallSizedBox,
                    CustomDropDown(
                      titleText: 'Gender',
                      dropDownList: Gender.values,
                      controller: _genderController,
                    ),
                    AppSpacing.smallSizedBox,
                    CustomTextFormField(
                      controller: _dobController,
                      titleText: 'DOB',
                      readOnly: true,
                      onTap: () => _showDatePicker(),
                      validator: (value) =>
                          sl<AppValidator>().validateEmptyText('dob', value),
                    ),
                    AppSpacing.smallSizedBox,
                    CustomTextFormField(
                      controller: _addressController,
                      titleText: 'Address',
                    ),
                    AppSpacing.largeSizedBox,
                    DeleteAccountButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
