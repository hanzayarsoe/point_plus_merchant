import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_constants.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/home/presentation/bloc/point_request_bloc/point_request_bloc.dart';
import 'package:merchant/shared/widgets/confirm_box.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:merchant/shared/widgets/show_success_toast.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _pointController = TextEditingController();
  late final PointRequestBloc _pointRequestBloc;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _pointRequestBloc = PointRequestBloc(sl());
  }

  @override
  void dispose() {
    _pointController.dispose();
    _pointRequestBloc.close();
    super.dispose();
  }

  bool _inSufficientBalance(Branch? branch) {
    final int amountToWithdraw =
        int.tryParse(_pointController.text.trim()) ?? 0;
    final int currentBalance = branch?.branchAmount ?? 0;
    return currentBalance < amountToWithdraw;
  }

  bool _lessThanMinimumRequest() {
    final int amountToWithdraw =
        int.tryParse(_pointController.text.trim()) ?? 0;
    return amountToWithdraw < AppConstants.minRequestPoints;
  }

  void _withdrawPoints(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ConfirmBox(
          title: 'Withdraw',
          body: 'Are you sure to withdraw ?',
          mainActionText: 'Withdraw',
          mainAction: () {
            dialogContext.pop();
            final points = int.tryParse(_pointController.text.trim()) ?? 0;
            context.read<PointRequestBloc>().add(
              PointRequestEvent.requestPoint(
                points: points,
                type: RequestTransactionType.withdraw,
              ),
            );
          },
          secondaryActionText: 'Cancel',
          secondaryAction: () => dialogContext.pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final branchState = context.watch<AuthBloc>().state;
    final branch = branchState.whenOrNull(authenticated: (branch) => branch);
    return BlocProvider.value(
      value: _pointRequestBloc,
      child: BlocConsumer<PointRequestBloc, PointRequestState>(
        listenWhen: (previous, current) => current.maybeWhen(
          orElse: () => false,
          success: () => true,
          failed: (failure) => true,
        ),
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: () {
              showSuccessToast(context, 'Successfully request sent!');
              _pointController.clear();
            },
            failed: (failure) =>
                showToast(message: failure.message, type: ToastType.error),
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
                title: 'Withdraw Points',
                automaticallyImplyLeading: true,
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: AppSpacing.defaultPadding,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: _pointController,
                              maxLength: 19,
                              inputType: TextInputType.number,
                              textInputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              errorText: _errorText,
                              onChanged: (_) {
                                setState(() {
                                  if (_inSufficientBalance(branch)) {
                                    _errorText = 'Insufficient Balance';
                                  } else if (_lessThanMinimumRequest()) {
                                    _errorText =
                                        'Less than minimum points to withdraw';
                                  } else {
                                    _errorText = null;
                                  }
                                });
                              },
                            ),
                            AppSpacing.smallSizedBox,
                            Text(
                              'Point Balance : ${branch?.branchAmount} pts',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).extension<AppColors>()!.softBlueColor,
                                  ),
                            ),
                            AppSpacing.megaLargeSizedBox,
                            Container(
                              padding: AppSpacing.normalPadding,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius:
                                    AppSpacing.smallCircularBorderRadius,
                              ),
                              child: Row(
                                spacing: AppSpacing.smallSpacing,
                                children: [
                                  Icon(
                                    LucideIcons.badgeInfo,
                                    size: 20,
                                    color: Theme.of(
                                      context,
                                    ).extension<AppColors>()!.softBlueColor,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Minimum points to withdraw is ${Formatter.formatNumber(10000)} pts!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .extension<AppColors>()!
                                                .softBlueColor,
                                          ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSpacing.extraLargeSizedBox,
                            GradientElevatedButton(
                              onPressed: () => _withdrawPoints(context),
                              text: 'Done',
                              isDisabled:
                                  _pointController.text.trim().isEmpty ||
                                  _errorText != null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
