part of 'request_transaction_detail_bloc.dart';

@freezed
class RequestTransactionDetailState with _$RequestTransactionDetailState {
  const factory RequestTransactionDetailState.initial() = _Initial;
  const factory RequestTransactionDetailState.loading() = _Loading;
  const factory RequestTransactionDetailState.loaded(
    PointRequestEntity requestDetail,
  ) = _loaded;
  const factory RequestTransactionDetailState.failed(Failure failure) = _Failed;
}
