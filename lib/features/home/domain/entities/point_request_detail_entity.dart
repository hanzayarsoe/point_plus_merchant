import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_request_detail_entity.freezed.dart';

@freezed
abstract class PointRequestDetailEntity with _$PointRequestDetailEntity {
  const factory PointRequestDetailEntity({
    required int id,
    required int branchId,
    required String branchName,
    required int merchantId,
    required String merchantName,
    String? merchantProfile,
    required String type,
    required String status,
    String? note,
    required int amount,
    required String createdAt,
    required String updatedAt,
  }) = _PointRequestDetailEntity;
}
