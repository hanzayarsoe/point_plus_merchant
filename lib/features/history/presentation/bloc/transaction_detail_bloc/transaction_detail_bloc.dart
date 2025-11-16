import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/domain/usecases/get_transaction_detail_usecase.dart';
import 'package:merchant/features/home/domain/entities/transaction_entity.dart';

part 'transaction_detail_event.dart';
part 'transaction_detail_state.dart';
part 'transaction_detail_bloc.freezed.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  final GetTransactionDetailUsecase getTransactionDetailUsecase;
  TransactionDetailBloc(this.getTransactionDetailUsecase) : super(_Initial()) {
    on<_GetTransatcionDetail>(_onGetTransactionDetail);
  }

  Future<void> _onGetTransactionDetail(
    _GetTransatcionDetail event,
    Emitter<TransactionDetailState> emit,
  ) async {
    emit(TransactionDetailState.loading());
    final result = await getTransactionDetailUsecase.call(id: event.id).run();
    result.fold(
      (failure) => emit(TransactionDetailState.failed(failure)),
      (transaction) => emit(TransactionDetailState.loaded(transaction)),
    );
  }
}
