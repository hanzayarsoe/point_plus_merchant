part of 'transaction_detail_bloc.dart';

@freezed
abstract class TransactionDetailEvent with _$TransactionDetailEvent {
  const factory TransactionDetailEvent.getTransactionDetail({required int id}) =
      _GetTransatcionDetail;
}
