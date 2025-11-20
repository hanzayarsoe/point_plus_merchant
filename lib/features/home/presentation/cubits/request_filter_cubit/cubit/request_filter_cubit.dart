import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/constants/enum.dart';

part 'request_filter_state.dart';
part 'request_filter_cubit.freezed.dart';

class RequestFilterCubit extends Cubit<RequestFilterState> {
  RequestFilterCubit() : super(RequestFilterState());
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

  void clearFilters() {
    emit(RequestFilterState());
  }
}
