import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/constants/enum.dart';

part 'history_filter_state.dart';
part 'history_filter_cubit.freezed.dart';

class HistoryFilterCubit extends Cubit<HistoryFilterState> {
  HistoryFilterCubit() : super(HistoryFilterState());
  void updateFilters({
    HistoryTransactionType? type,
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
    emit(HistoryFilterState());
  }
}
