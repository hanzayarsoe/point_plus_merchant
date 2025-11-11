part of 'item_bloc.dart';

@freezed
abstract class ItemEvent with _$ItemEvent {
  const factory ItemEvent.fetchPage({
    required int merchantId,
    required bool allItems,
    required bool promoItems,
  }) = _FetchPage;
}
