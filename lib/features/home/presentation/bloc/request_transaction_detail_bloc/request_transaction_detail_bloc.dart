import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';
import 'package:merchant/features/home/domain/usecases/get_request_detail_usecase.dart';

part 'request_transaction_detail_event.dart';
part 'request_transaction_detail_state.dart';
part 'request_transaction_detail_bloc.freezed.dart';

class RequestTransactionDetailBloc
    extends Bloc<RequestTransactionDetailEvent, RequestTransactionDetailState> {
  final GetRequestDetailUsecase getRequestDetailUsecase;
  RequestTransactionDetailBloc(this.getRequestDetailUsecase)
    : super(_Initial()) {
    on<_GetTransactionDetail>(_onGetTransactionDetail);
  }

  Future<void> _onGetTransactionDetail(
    _GetTransactionDetail event,
    Emitter<RequestTransactionDetailState> emit,
  ) async {
    emit(RequestTransactionDetailState.loading());
    final result = await getRequestDetailUsecase.call(id: event.id).run();
    result.fold(
      (failure) => emit(RequestTransactionDetailState.failed(failure)),
      (requestDetail) =>
          emit(RequestTransactionDetailState.loaded(requestDetail)),
    );
  }
}
