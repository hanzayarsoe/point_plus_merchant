import 'package:freezed_annotation/freezed_annotation.dart';
part 'point_request_entity.freezed.dart';

@freezed
abstract class PointRequestEntity with _$PointRequestEntity {
  const factory PointRequestEntity.monthHeader({
    required String groupTitle,
    required String type,
  }) = _MonthHeader;

  const factory PointRequestEntity.transaction({
    required String createdAt,
    String? note,
    required int amount,
    required String requestType,
    required String type,
    required String branchName,
    required int id,
    required String merchantName,
    required String status,
  }) = Transaction;
}
