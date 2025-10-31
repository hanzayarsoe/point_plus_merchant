import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
import 'package:merchant/features/home/domain/usecases/transfer_point_usecase.dart';

part 'point_transfer_event.dart';
part 'point_transfer_state.dart';
part 'point_transfer_bloc.freezed.dart';

class PointTransferBloc extends Bloc<PointTransferEvent, PointTransferState> {
  final TransferPointUsecase transferPointUsecase;
  PointTransferBloc(this.transferPointUsecase) : super(_Initial()) {
    on<_TransferPoint>(_onTransferPoint);
  }

  Future<void> _onTransferPoint(
    _TransferPoint event,
    Emitter<PointTransferState> emit,
  ) async {
    emit(PointTransferState.loading());
    final result = await transferPointUsecase
        .call(event.pointTransferEntity)
        .run();
    result.fold(
      (failure) => emit(PointTransferState.failed(failure)),
      (_) => emit(PointTransferState.success()),
    );
  }
}
