part of 'point_transfer_bloc.dart';

@freezed
class PointTransferState with _$PointTransferState {
  const factory PointTransferState.initial() = _Initial;
  const factory PointTransferState.loading() = _Loading;
  const factory PointTransferState.success() = _Success;
  const factory PointTransferState.failed(Failure failure) = _Failed;
}
