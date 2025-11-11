import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/features/profile/presentation/bloc/bloc/branch_bloc.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';
import 'package:merchant/shared/widgets/custom_drop_down.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
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
        _dobController.text = Formatter.formateDateOfBirth(date);
      });
    }
  }

  void _updateInfo() {
    if (!_formKey.currentState!.validate()) return;
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    final user = authState.whenOrNull(authenticated: (user) => user);
    if (user != null) {
      _nameController.text = user.manager.name;
      _nrcController.text = Formatter.formateNrcToString(user.manager.nrc);
      _mobileController.text = user.manager.phoneNumber ?? '';
      _emialController.text = user.manager.email ?? '';
      _genderController.text = user.manager.gender ?? '';
      _dobController.text = Formatter.formateStringToDateOfBirth(
        user.manager.dob ?? '',
      );
      _addressController.text = user.manager.address ?? '';
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
    return BlocConsumer<BranchBloc, BranchState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        updateBranchFailed: (failure) => true,
        updateBranchSuccessed: (updatedUser) => true,
      ),
      listener: (context, state) {
        // TODO: implement listener
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
