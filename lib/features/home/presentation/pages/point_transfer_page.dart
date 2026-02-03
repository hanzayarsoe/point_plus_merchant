import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
import 'package:merchant/features/home/presentation/bloc/point_transfer_bloc/point_transfer_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/noti_count_cubit/noti_count_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/point_transfer_customer_info_card.dart';
import 'package:merchant/shared/widgets/confirm_box.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:merchant/shared/widgets/show_success_toast.dart';

class PointTransferPage extends StatefulWidget {
  final PointTransferEntity pointTransferEntity;
  const PointTransferPage({super.key, required this.pointTransferEntity});

  @override
  State<PointTransferPage> createState() => _PointTransferPageState();
}

class _PointTransferPageState extends State<PointTransferPage> {
  final TextEditingController _pointController = TextEditingController();
  late String? _requestAmount;
  late bool _isTypeRedeem;
  late bool _isTypeRequest;
  String? _errorText;

  @override
  void initState() {
    _isTypeRedeem = widget.pointTransferEntity.type.toLowerCase().contains(
      'redeem',
    );
    _isTypeRequest = widget.pointTransferEntity.type.toLowerCase().contains(
      'request',
    );
    _requestAmount = widget.pointTransferEntity.amount;
    if (_requestAmount != null &&
        _requestAmount!.isNotEmpty &&
        _requestAmount != 'null') {
      setState(() {
        _pointController.text = _requestAmount!;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _pointController.dispose();
    super.dispose();
  }

  bool _inSufficientBalance(Branch? user) {
    final int amountToSend = int.tryParse(_pointController.text.trim()) ?? 0;

    final int currentBalance = user?.branchAmount ?? 0;

    return currentBalance < amountToSend;
  }

  void _transferPoint(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ConfirmBox(
        dialogType: DialogType.confirm,
        title: _isTypeRequest
            ? 'Send Points'
            : _isTypeRedeem
            ? 'Received Points'
            : '',
        body:
            "Are you sure to ${_isTypeRequest
                ? 'send'
                : _isTypeRedeem
                ? 'receive'
                : ''} ${_pointController.text.trim()} points to ${widget.pointTransferEntity.name} (${widget.pointTransferEntity.phoneNumber}) ?",
        mainActionText: _isTypeRequest
            ? 'Send'
            : _isTypeRedeem
            ? 'Receive'
            : '',
        mainAction: () {
          dialogContext.pop();
          context.read<PointTransferBloc>().add(
            PointTransferEvent.transferPoint(
              widget.pointTransferEntity.copyWith(
                amount: _pointController.text.trim(),
              ),
            ),
          );
        },
        secondaryActionText: 'Cancel',
        secondaryAction: () {
          dialogContext.pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTypeRequest = widget.pointTransferEntity.type
        .toLowerCase()
        .contains('request');
    final branchState = context.watch<AuthBloc>().state;
    final Branch? branch = branchState.whenOrNull(
      authenticated: (user) => user,
    );
    final bool isUserLoading = branchState.maybeWhen(
      orElse: () => false,
      loading: () => true,
    );
    return BlocConsumer<PointTransferBloc, PointTransferState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        success: () => true,
        failed: (failure) => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          failed: (failure) =>
              showToast(message: failure.message, type: ToastType.error),
          success: () {
            showSuccessToast(context, 'Successfully Transfer!');
            context.read<NotiCountCubit>().getUnreadCount();
            context.read<AuthBloc>().add(AuthEvent.refreshUser());
            context.goNamed(AppRoutes.home);
          },
        );
      },
      builder: (context, state) {
        final isPointTransferLoading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        final isLoading = isPointTransferLoading || isUserLoading;
        return LoadingOverlay(
          isLoading: isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              title: isTypeRequest ? 'Transfer Points' : 'Receive Points',
              automaticallyImplyLeading: true,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: AppSpacing.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.05),
                      PointTransferCustomerInfoCard(
                        customerName: widget.pointTransferEntity.name,
                        phoneNumber: widget.pointTransferEntity.phoneNumber,
                        customerProfile: widget.pointTransferEntity.profileUrl,
                        isTypeRequest: isTypeRequest,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.15),
                      CustomTextFormField(
                        controller: _pointController,
                        hintText: 'Enter Amount',
                        inputType: TextInputType.number,
                        maxLength: 20,
                        textInputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        errorText: _errorText,
                        onChanged: (_) {
                          setState(() {
                            final parsedPoints = int.tryParse(
                              _pointController.text.trim(),
                            );
                            if (isTypeRequest && _inSufficientBalance(branch)) {
                              _errorText = 'InSufficient Balance';
                            } else if (parsedPoints == null) {
                              _errorText = null;
                            } else if (parsedPoints <= 0) {
                              _errorText = 'Invalid Amount';
                            } else {
                              _errorText = null;
                            }
                          });
                        },
                      ),
                      AppSpacing.smallSizedBox,
                      Text(
                        'Your Point Balance : ${branch?.branchAmount} pts',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(
                            context,
                          ).extension<AppColors>()!.softBlueColor,
                        ),
                      ),
                      AppSpacing.extraLargeSizedBox,
                      GradientElevatedButton(
                        onPressed: () => _transferPoint(context),
                        text: 'Done',
                        isDisabled:
                            _pointController.text.trim().isEmpty ||
                            (_errorText != null),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
