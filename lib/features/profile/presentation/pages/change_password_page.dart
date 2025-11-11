import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/profile/presentation/bloc/bloc/branch_bloc.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/show_success_toast.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isButtonDisabled = true;
  String? _passwordMatchError;
  final AppValidator validator = sl<AppValidator>();
  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPassword() {
    _passwordMatchError = validator.passwordMatch(
      _newPasswordController.text.trim(),
      _confirmPasswordController.text.trim(),
    );
    _isButtonDisabled =
        _currentPasswordController.text.trim().isEmpty ||
        _newPasswordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty ||
        _passwordMatchError != null;
  }

  void _changePassword() {
    context.read<BranchBloc>().add(
      BranchEvent.changePassword(
        _currentPasswordController.text.trim(),
        _newPasswordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BranchBloc, BranchState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        changePasswordFailed: (failure) => true,
        changePasswordSuccessed: () => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          changePasswordFailed: (failure) => showToast(
            message: failure.message,
            type: ToastificationType.error,
          ),
          changePasswordSuccessed: () {
            showSuccessToast(context, 'Successfully changed!');
            context.pop();
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Change Password',
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            padding: AppSpacing.defaultPadding,
            child: Column(
              spacing: AppSpacing.extraLargeSpacing,
              children: [
                CustomTextFormField(
                  controller: _currentPasswordController,
                  titleText: 'Current password*',
                  onChanged: (_) => setState(() {
                    _checkPassword();
                  }),
                ),
                CustomTextFormField(
                  controller: _newPasswordController,
                  titleText: 'New password*',
                  onChanged: (_) => setState(() {
                    _checkPassword();
                  }),
                ),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  titleText: 'Retype new password*',
                  errorText: _passwordMatchError,
                  onChanged: (_) => setState(() {
                    _checkPassword();
                  }),
                ),
                GradientElevatedButton(
                  onPressed: () => _changePassword(),
                  text: 'Change',
                  isDisabled: _isButtonDisabled,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
