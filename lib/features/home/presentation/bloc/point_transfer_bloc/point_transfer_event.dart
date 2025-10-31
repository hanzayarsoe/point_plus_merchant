part of 'point_transfer_bloc.dart';

@freezed
abstract class PointTransferEvent with _$PointTransferEvent {
  const factory PointTransferEvent.transferPoint(
    PointTransferEntity pointTransferEntity,
  ) = _TransferPoint;
}
