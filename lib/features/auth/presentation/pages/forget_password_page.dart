import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/icon_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    setState(() {
      _errorText = sl<AppValidator>().validatePhoneNumber(
        _phoneController.text.trim(),
      );
    });
    if (_errorText != null) return;
    context.read<AuthBloc>().add(
      AuthEvent.sendOtp(_phoneController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return current.maybeWhen(
          orElse: () => false,
          sentOtpFailed: (failure) => true,
          sentOtpSuccessed: () => true,
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          sentOtpFailed: (failure) => showToast(message: failure.message),
          sentOtpSuccessed: () => context.pushNamed(
            AppRoutes.verifyNumber,
            extra: _phoneController.text.trim(),
          ),
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
              title: 'Forgot Password',
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Your Phone Number',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Enter your phone number. We’ll send a one-time verification code there.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  IconTextFormField(
                    controller: _phoneController,
                    prefixIcon: LucideIcons.smartphone,
                    keyboardType: TextInputType.phone,
                    errorText: _errorText,
                    hint: '- - - - - - - - - - -',
                    onChanged: (_) => setState(() {
                      if (_errorText != null) {
                        _errorText = null;
                      }
                    }),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: AppSpacing.bottomButtonPadding,
              child: GradientElevatedButton(
                onPressed: _sendOtp,
                text: 'Next',
                isDisabled: _phoneController.text.trim().isEmpty,
              ),
            ),
          ),
        );
      },
    );
  }
}
