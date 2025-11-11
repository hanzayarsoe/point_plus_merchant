part of 'store_bloc.dart';

@freezed
class StoreState with _$StoreState {
  const factory StoreState.initial() = _Initial;
  const factory StoreState.loading() = _Loading;
  const factory StoreState.loadedStoreData({
    required List<ItemEntity> promoItems,
    required List<ItemEntity> allItems,
  }) = _loadedStoreData;
  const factory StoreState.failed(Failure failure) = _Failed;
}
