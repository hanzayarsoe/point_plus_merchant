import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';
import 'package:merchant/features/home/domain/usecases/get_request_histories_usecase.dart';

part 'request_history_event.dart';
part 'request_history_bloc.freezed.dart';

class RequestHistoryBloc
    extends Bloc<RequestHistoryEvent, PagingState<int, PointRequestEntity>> {
  static const int _pageSize = 10;
  final GetRequestHistoriesUsecase getRequestHistoriesUsecase;
  RequestHistoryBloc(this.getRequestHistoriesUsecase)
    : super(PagingState(pages: [], keys: [], hasNextPage: true)) {
    on<_GetRequestHistories>(_onGetRequestHistories);
    on<_Reset>(_onReset);
  }
  Future<void> _onGetRequestHistories(
    _GetRequestHistories event,
    Emitter<PagingState<int, PointRequestEntity>> emit,
  ) async {
    final currentState = state;
    if (currentState.isLoading || !currentState.hasNextPage) {
      return;
    }

    emit(currentState.copyWith(isLoading: true));
    try {
      final pageKey = currentState.keys?.length ?? 0;
      final result = await getRequestHistoriesUsecase
          .call(
            page: pageKey,
            limit: _pageSize,
            startDate: event.startDate,
            endDate: event.endDate,
            requestType: event.requestType,
          )
          .run();
      result.fold(
        (failure) =>
            emit(currentState.copyWith(isLoading: false, error: failure)),
        (histories) {
          final isLastPage = histories.length < _pageSize;
          emit(
            currentState.copyWith(
              pages: [...?currentState.pages, histories],
              keys: [...?currentState.keys, pageKey],
              hasNextPage: !isLastPage,
              isLoading: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(currentState.copyWith(isLoading: false, error: e));
    }
  }

  Future<void> _onReset(
    _Reset event,
    Emitter<PagingState<int, PointRequestEntity>> emit,
  ) async {
    emit(PagingState(pages: [], keys: [], hasNextPage: true));
  }
}
