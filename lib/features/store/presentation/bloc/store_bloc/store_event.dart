part of 'store_bloc.dart';

@freezed
abstract class StoreEvent with _$StoreEvent {
  const factory StoreEvent.fetchStoreData({required int merchantId}) =
      _FetchStoreData;
}
