import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/domain/usecases/get_items_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';
part 'store_bloc.freezed.dart';

const int limit = 10;

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetItemsUsecase getItemsUsecase;
  StoreBloc(this.getItemsUsecase) : super(_Initial()) {
    on<_FetchStoreData>(_onFetchStoreData);
  }

  Future<void> _onFetchStoreData(
    _FetchStoreData event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoreState.loading());
    final results = await Future.wait([
      getItemsUsecase
          .call(
            page: 1,
            limit: limit,
            merchantId: event.merchantId,
            allItems: false,
            promoItems: true,
          )
          .run(),
      getItemsUsecase
          .call(
            page: 1,
            limit: limit,
            merchantId: event.merchantId,
            allItems: true,
            promoItems: false,
          )
          .run(),
    ]);
    final promoList = results[0];
    final allItemsList = results[1];
    if (promoList.isLeft() || allItemsList.isLeft()) {
      final failure = promoList.isLeft()
          ? promoList.getLeft().toNullable()!
          : allItemsList.getLeft().toNullable()!;
      emit(StoreState.failed(failure));
      return;
    }
    final promoItems = promoList.getRight().toNullable() ?? [];
    final allItems = allItemsList.getRight().toNullable() ?? [];
    emit(
      StoreState.loadedStoreData(promoItems: promoItems, allItems: allItems),
    );
  }
}
