part of 'devices_bloc.dart';

@freezed
class DevicesState with _$DevicesState {
  const factory DevicesState.initial() = _Initial;
  const factory DevicesState.loading() = _Loading;
  const factory DevicesState.loaded(List<DeviceEntity> devices) = _Loaded;
  const factory DevicesState.failed(Failure failure) = _Failed;
}
