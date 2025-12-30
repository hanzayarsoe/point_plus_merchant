import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/profile/domain/entities/device_entity.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
abstract class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    required String deviceId,
    required String deviceType,
    required String deviceName,
    required String ipAddress,
    required String userAgent,
    required DateTime lastUsedAt,
    required DateTime createdAt,
    required bool currentSession,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);
}

extension DeviceModelX on DeviceModel {
  DeviceEntity toEntity() => DeviceEntity(
        deviceId: deviceId,
        deviceType: deviceType,
        deviceName: deviceName,
        ipAddress: ipAddress,
        userAgent: userAgent,
        lastUsedAt: lastUsedAt,
        createdAt: createdAt,
        currentSession: currentSession,
      );
}
