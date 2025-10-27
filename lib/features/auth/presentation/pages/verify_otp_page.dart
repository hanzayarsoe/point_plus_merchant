import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_constants.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/shared/widgets/account_action_promt.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_pin_put_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNumber;
  const VerifyOtpPage({super.key, required this.phoneNumber});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _pinController = TextEditingController();
  Timer? _timer;
  int _remainingSecond = AppConstants.resendOtpWaitingTime;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSecond = AppConstants.resendOtpWaitingTime;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSecond > 0) {
        setState(() {
          _remainingSecond--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _verifyOtp() {
    context.read<AuthBloc>().add(
      AuthEvent.verifyOtp(widget.phoneNumber, _pinController.text.trim()),
    );
  }

  void _sendOtpAgain() {
    _startTimer();
    context.read<AuthBloc>().add(AuthEvent.sendOtp(widget.phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    final bool sendOtpAgain = _remainingSecond == 0;
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return current.maybeWhen(
          orElse: () => false,
          verifyOtpFailed: (failure) => true,
          verfiyOtpSuccessed: () => true,
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          verfiyOtpSuccessed: () => context.pushNamed(
            AppRoutes.resetPassword,
            extra: widget.phoneNumber,
          ),
          verifyOtpFailed: (failure) => showToast(
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
            appBar: CustomAppBar(
              title: 'Check Your Inbox',
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter OTP',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.smallSizedBox,
                  Text(
                    'We’ve sent a code to ${widget.phoneNumber}. Please enter it below to reset your password.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  Align(
                    child: Text(
                      '${Formatter.formatSecondToMinuteAndSecond(_remainingSecond)} sec',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  CustomPinPutField(
                    pinController: _pinController,
                    length: AppConstants.passwordLength,
                    isObsurce: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  GradientElevatedButton(
                    onPressed: _verifyOtp,
                    text: 'Next',
                    isDisabled:
                        _pinController.text.length !=
                        AppConstants.passwordLength,
                  ),
                  AppSpacing.smallSizedBox,
                  AccountActionPromt(
                    title: "Didn't receive the OTP code? ",
                    textButton: 'Resend',
                    onPressed: _sendOtpAgain,
                    isButtonDisabled: !sendOtpAgain,
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
