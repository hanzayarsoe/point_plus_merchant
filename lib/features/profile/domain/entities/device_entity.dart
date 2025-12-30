import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_entity.freezed.dart';

@freezed
abstract class DeviceEntity with _$DeviceEntity {
  const factory DeviceEntity({
    required String deviceId,
    required String deviceType,
    required String deviceName,
    required String ipAddress,
    required String userAgent,
    required DateTime lastUsedAt,
    required DateTime createdAt,
    required bool currentSession,
  }) = _DeviceEntity;
}
