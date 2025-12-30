import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/history/domain/usecases/get_histories_usecase.dart';

part 'history_event.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc
    extends Bloc<HistoryEvent, PagingState<int, HistoryListItemEntity>> {
  static const _pageSize = 10;
  final GetHistoriesUsecase getHistoriesUsecase;
  HistoryBloc(this.getHistoriesUsecase)
    : super(
        PagingState(
          pages: null,
          keys: null,
          hasNextPage: true,
          isLoading: false,
        ),
      ) {
    on<_GetHistories>(_onGetHistories);
    on<_Reset>(_onReset);
  }

  Future<void> _onGetHistories(
    _GetHistories event,
    Emitter<PagingState<int, HistoryListItemEntity>> emit,
  ) async {
    final currentState = state;
    if (currentState.isLoading || !currentState.hasNextPage) {
      return;
    }
    emit(currentState.copyWith(isLoading: true));
    try {
      final pageKey = currentState.keys?.length ?? 0;
      final result = await getHistoriesUsecase
          .call(
            page: pageKey,
            limit: _pageSize,
            type: event.type,
            startDate: event.startDate,
            endDate: event.endDate,
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
      emit(currentState.copyWith(error: e, isLoading: false));
    }
  }

  Future<void> _onReset(
    _Reset event,
    Emitter<PagingState<int, HistoryListItemEntity>> emit,
  ) async {
    emit(PagingState(pages: null, keys: null, hasNextPage: true));
  }
}
