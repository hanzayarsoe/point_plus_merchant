import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_constants.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/icon_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObsurce = true;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    _phoneController.addListener(_updateButton);
    _passwordController.addListener(_updateButton);
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _phoneController.removeListener(_updateButton);
    _passwordController.removeListener(_updateButton);
    super.dispose();
  }

  void _updateButton() {
    _isButtonDisabled =
        _phoneController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty;
  }

  void _logIn() {
    context.read<AuthBloc>().add(
      AuthEvent.logIn(
        _phoneController.text.trim(),
        _passwordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return current.maybeWhen(
          orElse: () => false,
          authenticated: (user) => true,
          unauthenticated: () => true,
          failure: (failure) => true,
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          failure: (failure) => showToast(
            message: failure.message,
            type: ToastificationType.error,
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
            appBar: CustomAppBar(automaticallyImplyLeading: true),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login your account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  AppSpacing.smallSizedBox,
                  Text(
                    'Enter your phone number. We’ll send a one-time verification code there.',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  IconTextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    hint: AppConstants.mobileTextFieldHintText,
                    prefixIcon: LucideIcons.smartphone,
                    onChanged: (_) => setState(() {}),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  IconTextFormField(
                    controller: _passwordController,
                    hint: AppConstants.mobileTextFieldHintText,
                    prefixIcon: LucideIcons.lock,
                    isObsurce: _isObsurce,
                    suffixIcon: _isObsurce
                        ? LucideIcons.eyeClosed
                        : LucideIcons.eye,
                    suffixIconPreesed: () => setState(() {
                      _isObsurce = !_isObsurce;
                    }),
                    onChanged: (_) => setState(() {}),
                  ),
                  AppSpacing.smallSizedBox,
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          context.pushNamed(AppRoutes.forgetPassword),
                      child: Text(
                        'forgot password?',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: AppSpacing.bottomButtonPadding,
              child: GradientElevatedButton(
                onPressed: _logIn,
                text: 'next',
                isDisabled: _isButtonDisabled,
              ),
            ),
          ),
        );
      },
    );
  }
}
