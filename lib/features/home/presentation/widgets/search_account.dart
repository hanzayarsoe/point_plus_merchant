import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
import 'package:merchant/features/home/presentation/cubits/cubit/search_customer_cubit.dart';
import 'package:merchant/shared/widgets/custom_text_form_field.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class SearchAccount extends StatefulWidget {
  final String type;
  const SearchAccount({super.key, required this.type});

  @override
  State<SearchAccount> createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  final TextEditingController _accountController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCustomerCubit, SearchCustomerState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        loadedCustomer: (customer) => true,
        failed: (failure) => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loadedCustomer: (customer) {
            final pointTransferEntity = PointTransferEntity(
              accountNumber: customer.accountNumber,
              name: customer.name,
              profileUrl: customer.profileUrl,
              type: widget.type,
            );
            context.pushNamed(
              AppRoutes.pointTransfer,
              extra: pointTransferEntity,
            );
          },
          failed: (failure) => showToast(
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: AppSpacing.defaultPadding,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.2),
                      CustomTextFormField(
                        controller: _accountController,
                        inputType: TextInputType.number,
                        hintText: 'Enter Account Number',
                        onChanged: (_) => setState(() {}),
                        validator: (value) => _errorText = sl<AppValidator>()
                            .validateAccountNumber(value!),
                        errorText: _errorText,
                        maxLength: 20,
                        textInputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      AppSpacing.extraLargeSizedBox,
                      GradientElevatedButton(
                        onPressed: () => context
                            .read<SearchCustomerCubit>()
                            .searchUser(_accountController.text.trim()),
                        text: 'Search',
                        isDisabled:
                            _accountController.text.isEmpty ||
                            _errorText != null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
