import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:merchant/features/history/presentation/cubit/cubit/history_filter_cubit.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_header.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_row.dart';
import 'package:merchant/features/home/presentation/cubits/request_transaction_cubit/cubit/request_transaction_cubit.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';

class RequestTransaction extends StatefulWidget {
  const RequestTransaction({super.key});

  @override
  State<RequestTransaction> createState() => _RequestTransactionState();
}

class _RequestTransactionState extends State<RequestTransaction> {
  late HistoryBloc _historyBloc;
  @override
  void initState() {
    super.initState();
    _historyBloc = context.read<HistoryBloc>();
    _fetchPage(isFirstFetch: true);
  }

  void _fetchPage({required bool isFirstFetch}) {
    if (isFirstFetch) {
      _historyBloc.add(HistoryEvent.reset());
    }
    final filterState = context.read<HistoryFilterCubit>().state;
    _historyBloc.add(
      HistoryEvent.getHistories(
        type: filterState.type,
        startDate: Formatter.formatDateToStringDate(filterState.startDate),
        endDate: Formatter.formatDateToStringDate(filterState.endDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, PagingState<int, HistoryListItemEntity>>(
      builder: (context, state) {
        return BlocListener<RequestTransactionCubit, RequestTransactionState>(
          listener: (context, state) {
            _fetchPage(isFirstFetch: true);
          },
          child: LoadingOverlay(
            isLoading: state.isLoading,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.largeSpacing,
              ),
              child: CustomScrollView(
                slivers: [
                  PagedSliverList(
                    state: state,
                    fetchNextPage: () => {},
                    builderDelegate:
                        PagedChildBuilderDelegate<HistoryListItemEntity>(
                          itemBuilder: (context, item, index) {
                            return item.when(
                              monthHeader: (type, groupTitle, inflow, outflow) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: AppSpacing.largeSpacing,
                                  ),
                                  child: TransactionHeader(
                                    groupTitle: groupTitle,
                                    inflow: inflow,
                                    outflow: outflow,
                                  ),
                                );
                              },
                              transaction:
                                  (id, date, amount, type, title, party) {
                                    if (title == null) return SizedBox.shrink();
                                    return InkWell(
                                      onTap: () => context.pushNamed(
                                        AppRoutes.transactionDetail,
                                        pathParameters: {'id': id.toString()},
                                      ),
                                      child: TransactionRow(
                                        title: title,
                                        date: date,
                                        amount: amount.toString(),
                                        party: party,
                                      ),
                                    );
                                  },
                            );
                          },
                        ),
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
