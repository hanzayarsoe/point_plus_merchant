part of 'noti_bloc.dart';

@freezed
class NotiEvent with _$NotiEvent {
  const factory NotiEvent.getNotifs() = _getNotifs;
  const factory NotiEvent.markAsRead({required String id}) = _MarkAsRead;
  const factory NotiEvent.reset() = _Reset;
}
