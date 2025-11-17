import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_row.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(sl())
        ..add(
          HistoryEvent.getHistories(type: null, startDate: null, endDate: null),
        ),
      child: BlocBuilder<HistoryBloc, PagingState<int, HistoryListItemEntity>>(
        builder: (context, state) {
          return PagedListView(
            state: state,
            fetchNextPage: () => {},
            builderDelegate: PagedChildBuilderDelegate<HistoryListItemEntity>(
              itemBuilder: (context, item, index) {
                return item.maybeWhen(
                  orElse: () => SizedBox.shrink(),
                  transaction: (id, date, amount, type, title, party) {
                    return TransactionRow(
                      title: title ?? '',
                      date: date,
                      amount: amount.toString(),
                      party: party,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
