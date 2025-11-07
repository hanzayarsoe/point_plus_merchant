import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_constants.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/icon_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';

class ChangeMobileNumberPage extends StatefulWidget {
  const ChangeMobileNumberPage({super.key});

  @override
  State<ChangeMobileNumberPage> createState() => _ChangeMobileNumberPageState();
}

class _ChangeMobileNumberPageState extends State<ChangeMobileNumberPage> {
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    context.read<UserBloc>().add(
      UserEvent.sendOtpToChangeNumber(_mobileNumberController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        sentOtpFailed: (failure) => true,
        sentOtpSuccessed: () => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          sentOtpFailed: (failure) => showToast(message: failure.message),
          sentOtpSuccessed: () {
            context.pushNamed(
              AppRoutes.changeMobileNumberVerifyOtp,
              extra: _mobileNumberController.text.trim(),
            );
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
              title: 'Change Mobile Number',
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change your mobile number',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppSpacing.smallSizedBox,
                  Text(
                    'Enter your phone number. We’ll send a one-time verification code there.',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  IconTextFormField(
                    prefixIcon: LucideIcons.smartphone,
                    hint: AppConstants.mobileTextFieldHintText,
                    controller: _mobileNumberController,
                    maxLength: AppConstants.maxPhoneNumber,
                    onChanged: (_) => setState(() {}),
                  ),
                  AppSpacing.extraLargeSizedBox,
                  GradientElevatedButton(
                    onPressed: _sendOtp,
                    text: 'Change',
                    isDisabled:
                        _mobileNumberController.text.length !=
                        AppConstants.maxPhoneNumber,
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
