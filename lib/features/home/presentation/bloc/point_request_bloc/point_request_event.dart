part of 'point_request_bloc.dart';

@freezed
abstract class PointRequestEvent with _$PointRequestEvent {
  const factory PointRequestEvent.requestPoint({
    required int points,
    required RequestTransactionType type,
  }) = _RequestPoint;
}
