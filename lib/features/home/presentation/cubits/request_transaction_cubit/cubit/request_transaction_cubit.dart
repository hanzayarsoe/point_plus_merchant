import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/constants/enum.dart';

part 'request_transaction_state.dart';
part 'request_transaction_cubit.freezed.dart';

class RequestTransactionCubit extends Cubit<RequestTransactionState> {
  RequestTransactionCubit() : super(RequestTransactionState());

  void updateFilters({
    RequestTransactionType? type,
    int? selectedChipIndex,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    emit(
      state.copyWith(
        type: type ?? state.type,
        selectedChipIndex: selectedChipIndex ?? state.selectedChipIndex,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }
}
