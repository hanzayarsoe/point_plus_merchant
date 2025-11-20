import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/features/history/presentation/widgets/transaction_header.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';
import 'package:merchant/features/home/presentation/bloc/request_history_bloc/request_history_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/request_filter_cubit/cubit/request_filter_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/request_transaction_row.dart';

class RequestTransaction extends StatefulWidget {
  const RequestTransaction({super.key});

  @override
  State<RequestTransaction> createState() => _RequestTransactionState();
}

class _RequestTransactionState extends State<RequestTransaction> {
  late RequestHistoryBloc _requestHistoryBloc;
  @override
  void initState() {
    super.initState();
    _requestHistoryBloc = context.read<RequestHistoryBloc>();
    _fetchPage(isFirstFetch: true);
  }

  void _fetchPage({required bool isFirstFetch}) {
    if (isFirstFetch) {
      _requestHistoryBloc.add(RequestHistoryEvent.reset());
    }
    final filterState = context.read<RequestFilterCubit>().state;
    _requestHistoryBloc.add(
      RequestHistoryEvent.getRequestHistories(
        requestType: filterState.type,
        startDate: Formatter.formatDateToStringDate(filterState.startDate),
        endDate: Formatter.formatDateToStringDate(filterState.endDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      RequestHistoryBloc,
      PagingState<int, PointRequestEntity>
    >(
      builder: (context, state) {
        return BlocListener<RequestFilterCubit, RequestFilterState>(
          listener: (context, state) {
            _fetchPage(isFirstFetch: true);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.largeSpacing),
            child: CustomScrollView(
              slivers: [
                PagedSliverList(
                  state: state,
                  fetchNextPage: () => _fetchPage(isFirstFetch: false),
                  builderDelegate:
                      PagedChildBuilderDelegate<PointRequestEntity>(
                        itemBuilder: (context, item, index) {
                          return item.when(
                            monthHeader: (groupTitle, type) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  top: AppSpacing.largeSpacing,
                                ),
                                child: TransactionHeader(
                                  groupTitle: groupTitle,
                                  inflow: null,
                                  outflow: null,
                                ),
                              );
                            },
                            transaction:
                                (
                                  createdAt,
                                  note,
                                  amount,
                                  requestType,
                                  type,
                                  branchName,
                                  id,
                                  merchantName,
                                  status,
                                ) {
                                  return InkWell(
                                    onTap: () => context.pushNamed(
                                      AppRoutes.requestTransactionDetail,
                                      extra: item,
                                    ),
                                    child: RequestTransactionRow(
                                      title: requestType,
                                      date: createdAt,
                                      amount: amount.toString(),
                                      status: status,
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
        );
      },
    );
  }
}
