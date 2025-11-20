part of 'request_history_bloc.dart';

@freezed
abstract class RequestHistoryEvent with _$RequestHistoryEvent {
  const factory RequestHistoryEvent.getRequestHistories({
    required String? startDate,
    required String? endDate,
    required RequestTransactionType requestType,
  }) = _GetRequestHistories;

  const factory RequestHistoryEvent.reset() = _Reset;
}
