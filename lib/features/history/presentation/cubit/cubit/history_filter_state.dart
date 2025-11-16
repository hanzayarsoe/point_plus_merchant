part of 'history_filter_cubit.dart';

@freezed
abstract class HistoryFilterState with _$HistoryFilterState {
  const factory HistoryFilterState({
    @Default(HistoryTransactionType.all) HistoryTransactionType type,
    @Default(-1) int selectedChipIndex,
    DateTime? startDate,
    DateTime? endDate,
  }) = _HistoryFilterState;
}
