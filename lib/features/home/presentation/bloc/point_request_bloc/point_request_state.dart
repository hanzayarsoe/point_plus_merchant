part of 'point_request_bloc.dart';

@freezed
class PointRequestState with _$PointRequestState {
  const factory PointRequestState.initial() = _Initial;
  const factory PointRequestState.loading() = _Loading;
  const factory PointRequestState.success() = _Success;
  const factory PointRequestState.failed(Failure failure) = _Failed;
}
