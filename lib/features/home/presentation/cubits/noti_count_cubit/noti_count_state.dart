part of 'noti_count_cubit.dart';

@freezed
class NotiCountState with _$NotiCountState {
  const factory NotiCountState.initial() = _Initial;
  const factory NotiCountState.loading() = _Loading;
  const factory NotiCountState.loaded(int count) = _Loaded;
  const factory NotiCountState.error(Failure message) = _Error;
}
