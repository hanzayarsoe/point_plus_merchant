part of 'request_filter_cubit.dart';

@freezed
abstract class RequestFilterState with _$RequestFilterState {
  const factory RequestFilterState({
    @Default(RequestTransactionType.all) RequestTransactionType type,
    @Default(-1) int selectedChipIndex,
    DateTime? startDate,
    DateTime? endDate,
  }) = _RecentFilterState;
}
