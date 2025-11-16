part of 'transaction_detail_bloc.dart';

@freezed
class TransactionDetailState with _$TransactionDetailState {
  const factory TransactionDetailState.initial() = _Initial;
  const factory TransactionDetailState.loading() = _Loading;
  const factory TransactionDetailState.loaded(TransactionEntity transaction) =
      _Loaded;
  const factory TransactionDetailState.failed(Failure failure) = _Failed;
}
