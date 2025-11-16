part of 'history_bloc.dart';

@freezed
abstract class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.getHistories({
    required HistoryTransactionType? type,
    required String? startDate,
    required String? endDate,
  }) = _GetHistories;

  const factory HistoryEvent.reset() = _Reset;
}
