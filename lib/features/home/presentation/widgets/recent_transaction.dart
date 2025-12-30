import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_row.dart';
import 'package:merchant/shared/widgets/empty_state_widget.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, PagingState<int, HistoryListItemEntity>>(
      builder: (context, state) {
        final isInitial = state.pages == null || state.pages!.isEmpty;
        final shouldShowLoading =
            (state.isLoading || isInitial) && state.error == null;
        final modifiedState = state.copyWith(
          hasNextPage: false,
          isLoading: shouldShowLoading,
        );
        return PagedSliverList(
          state: modifiedState,
          fetchNextPage: () {},
          builderDelegate: PagedChildBuilderDelegate<HistoryListItemEntity>(
            firstPageProgressIndicatorBuilder: (context) =>
                const Center(child: CupertinoActivityIndicator()),
            noItemsFoundIndicatorBuilder: (context) => const EmptyStateWidget(
              icon: LucideIcons.fileX,
              title: 'No recent transaction available',
            ),
            itemBuilder: (context, item, index) {
              return item.maybeWhen(
                orElse: () => SizedBox.shrink(),
                transaction: (id, date, amount, type, title, party) {
                  return TransactionRow(
                    onTap: () => context.pushNamed(
                      AppRoutes.transactionDetail,
                      pathParameters: {"id": id.toString()},
                    ),
                    title: title ?? '',
                    date: date,
                    amount: amount.toString(),
                    party: party,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
