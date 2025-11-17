part of 'request_transaction_cubit.dart';

@freezed
abstract class RequestTransactionState with _$RequestTransactionState {
  const factory RequestTransactionState({
    @Default(RequestTransactionType.all) RequestTransactionType type,
    @Default(-1) int selectedChipIndex,
    DateTime? startDate,
    DateTime? endDate,
  }) = _RecentTransactionState;
}
