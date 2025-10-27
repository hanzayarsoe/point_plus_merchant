part of 'connection_cubit.dart';

@freezed
class ConnectionState with _$ConnectionState {
  const factory ConnectionState.initial() = _Initial;
  const factory ConnectionState.connected() = _Connected;
  const factory ConnectionState.disconnected() = _Disconnected;
}
