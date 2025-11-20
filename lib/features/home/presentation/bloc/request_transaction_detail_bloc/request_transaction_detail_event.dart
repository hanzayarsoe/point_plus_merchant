part of 'request_transaction_detail_bloc.dart';

@freezed
abstract class RequestTransactionDetailEvent
    with _$RequestTransactionDetailEvent {
  const factory RequestTransactionDetailEvent.getTransactionDetail({
    required int id,
  }) = _GetTransactionDetail;
}
