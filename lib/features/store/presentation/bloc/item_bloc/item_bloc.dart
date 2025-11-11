import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/domain/usecases/get_items_usecase.dart';

part 'item_event.dart';
part 'item_bloc.freezed.dart';

class ItemBloc extends Bloc<ItemEvent, PagingState<int, ItemEntity>> {
  static const int _pageSize = 10;
  final GetItemsUsecase getItemsUsecase;
  ItemBloc(this.getItemsUsecase)
    : super(PagingState(pages: [], keys: [], hasNextPage: true)) {
    on<_FetchPage>(_onFetchPage);
  }

  Future<void> _onFetchPage(_FetchPage event, Emitter<PagingState> emit) async {
    final currentState = state;
    if (currentState.isLoading || !currentState.hasNextPage) {
      return;
    }
    try {
      final pageKey = (currentState.keys?.lastOrNull ?? 0) + 1;
      final result = await getItemsUsecase
          .call(
            page: pageKey,
            limit: _pageSize,
            merchantId: event.merchantId,
            allItems: event.allItems,
            promoItems: event.promoItems,
          )
          .run();
      result.fold(
        (failure) =>
            emit(currentState.copyWith(error: failure, isLoading: false)),
        (newItems) {
          final isLastPage = newItems.length < _pageSize;
          emit(
            currentState.copyWith(
              pages: [...?currentState.pages, newItems],
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
}
