import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_detail_row.dart';
import 'package:merchant/features/home/domain/entities/point_request_detail_entity.dart';
import 'package:merchant/features/home/presentation/bloc/request_transaction_detail_bloc/request_transaction_detail_bloc.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class RequestTransactionDetailPage extends StatefulWidget {
  final String requestId;
  const RequestTransactionDetailPage({super.key, required this.requestId});

  @override
  State<RequestTransactionDetailPage> createState() =>
      _RequestTransactionDetailPageState();
}

class _RequestTransactionDetailPageState
    extends State<RequestTransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    final parsedRequestId = int.tryParse(widget.requestId);
    if (parsedRequestId == null) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Details', automaticallyImplyLeading: true),
        body: const Center(child: Text('Invalid request id')),
      );
    }

    return BlocProvider(
      create: (context) => RequestTransactionDetailBloc(sl())
        ..add(
          RequestTransactionDetailEvent.getTransactionDetail(
            id: parsedRequestId,
          ),
        ),
      child: BlocBuilder<RequestTransactionDetailBloc, RequestTransactionDetailState>(
        builder: (context, state) {
          final failedMessage = state.maybeWhen(
            failed: (failure) => failure.message,
            orElse: () => null,
          );
          if (failedMessage != null) {
            return Scaffold(
              appBar: CustomAppBar(
                title: 'Details',
                automaticallyImplyLeading: true,
              ),
              body: Center(
                child: Padding(
                  padding: AppSpacing.defaultPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(failedMessage, textAlign: TextAlign.center),
                      AppSpacing.mediumSizedBox,
                      ElevatedButton(
                        onPressed: () =>
                            context.read<RequestTransactionDetailBloc>().add(
                              RequestTransactionDetailEvent.getTransactionDetail(
                                id: parsedRequestId,
                              ),
                            ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final PointRequestDetailEntity? transaction = state.whenOrNull(
            loaded: (requestDetail) => requestDetail,
          );

          if (transaction == null) {
            return Scaffold(
              appBar: CustomAppBar(
                title: 'Details',
                automaticallyImplyLeading: true,
              ),
              body: const Center(child: CupertinoActivityIndicator()),
            );
          }

          final isRecharge = transaction.type.toLowerCase().contains(
            'recharge',
          );
          final isPending = transaction.status.toLowerCase().contains(
            'pending',
          );
          final isReject = transaction.status.toLowerCase().contains('reject');
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Details',
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              padding: AppSpacing.defaultPadding,
              child: Column(
                children: [
                  Container(
                    padding: AppSpacing.transactionDetailCardPadding,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: AppSpacing.smallCircularBorderRadius,
                    ),
                    child: Column(
                      children: [
                        CustomIcon(
                          icon: Icon(
                            isRecharge
                                ? LucideIcons.arrowDownLeft
                                : LucideIcons.sparkle,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          padding: AppSpacing.smallPadding,
                          paddingColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                        ),
                        AppSpacing.smallSizedBox,
                        Text(
                          'Points ${isRecharge ? 'Recharge' : 'Withdraw'}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        AppSpacing.largeSizedBox,
                        Divider(color: Theme.of(context).colorScheme.secondary),
                        AppSpacing.smallSizedBox,
                        AppSpacing.smallSizedBox,
                        TransactionDetailRow(
                          title: 'Status',
                          text: isReject
                              ? 'Reject'
                              : isPending
                              ? 'Pending'
                              : 'Accept',
                          textStyle: Theme.of(context).textTheme.labelMedium!
                              .copyWith(
                                color: isReject
                                    ? Theme.of(context).colorScheme.error
                                    : isPending
                                    ? Theme.of(
                                        context,
                                      ).extension<AppColors>()!.pendingColor
                                    : Theme.of(
                                        context,
                                      ).extension<AppColors>()!.actionBlueColor,
                              ),
                        ),
                        AppSpacing.largeSizedBox,
                        TransactionDetailRow(
                          title: 'Total Points',
                          text:
                              '${isRecharge ? '+' : '-'} ${transaction.amount} pts',
                        ),
                        AppSpacing.largeSizedBox,
                        TransactionDetailRow(
                          title: 'Request Id',
                          text: '${transaction.id}',
                        ),
                        AppSpacing.largeSizedBox,
                        TransactionDetailRow(
                          title: 'Transaction Type',
                          text: isRecharge ? 'Recharge' : 'Withdraw',
                        ),
                        AppSpacing.largeSizedBox,
                        TransactionDetailRow(
                          title: 'Date',
                          text: Formatter.formatUtcTimeToHistoryTransactionDate(
                            transaction.createdAt,
                          ),
                        ),
                        AppSpacing.largeSizedBox,
                        TransactionDetailRow(
                          title: 'Time',
                          text: Formatter.formatUtcTimeToHistoryTransactionTime(
                            transaction.createdAt,
                          ),
                        ),
                        if (transaction.note != null) ...[
                          TransactionDetailRow(
                            title: 'Note',
                            titleTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).extension<AppColors>()!.pendingColor,
                                ),
                            text: transaction.note!,
                            textStyle: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).extension<AppColors>()!.pendingColor,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
