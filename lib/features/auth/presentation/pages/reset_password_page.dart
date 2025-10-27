import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phoneNumber;
  const ResetPasswordPage({super.key, required this.phoneNumber});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _passwordMatchError;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordMatch() {
    setState(() {
      _passwordMatchError = sl<AppValidator>().passwordMatch(
        _newPasswordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );
    });
  }

  void _resetPassword() {
    context.read<AuthBloc>().add(
      AuthEvent.resetPassword(
        widget.phoneNumber,
        _confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        resetPasswordFailed: (failure) => true,
        resetPasswordSuccessed: () => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          resetPasswordFailed: (failure) => showToast(
            message: failure.message,
            type: ToastificationType.error,
          ),
          resetPasswordSuccessed: () {
            showToast(
              message: 'password changed successfully! please login again',
              type: ToastificationType.success,
            );
            context.goNamed(AppRoutes.logIn);
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
              title: 'Forget Password',
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _newPasswordController,
                    titleText: 'New Password*',
                    onChanged: (_) => _checkPasswordMatch(),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    titleText: 'Retype new password*',
                    errorText: _passwordMatchError,
                    onChanged: (_) => _checkPasswordMatch(),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  GradientElevatedButton(
                    onPressed: _resetPassword,
                    text: 'Confirm',
                    isDisabled:
                        _passwordMatchError != null ||
                        _confirmPasswordController.text.trim().isEmpty,
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
