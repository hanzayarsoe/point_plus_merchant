import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';

part 'point_request_model.freezed.dart';
part 'point_request_model.g.dart';

@Freezed(unionKey: 'type')
abstract class PointRequestModel with _$PointRequestModel {
  @FreezedUnionValue('monthHeader')
  const factory PointRequestModel.monthHeader({
    required String groupTitle,
    required String type,
  }) = _MonthHeader;

  @FreezedUnionValue('request')
  const factory PointRequestModel.transaction({
    required String createdAt,
    String? note,
    required int amount,
    required String requestType,
    required String type,
    required String branchName,
    required int id,
    required String merchantName,
    required String status,
  }) = _Transaction;

  factory PointRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PointRequestModelFromJson(json);
}

extension PointRequestModelX on PointRequestModel {
  PointRequestEntity toEntity() {
    return when(
      monthHeader: (groupTitle, type) {
        return PointRequestEntity.monthHeader(
          groupTitle: groupTitle,
          type: type,
        );
      },
      transaction:
          (
            createdAt,
            note,
            amount,
            requestType,
            type,
            branchName,
            id,
            merchantName,
            status,
          ) {
            return PointRequestEntity.transaction(
              createdAt: createdAt,
              amount: amount,
              requestType: requestType,
              type: type,
              branchName: branchName,
              id: id,
              merchantName: merchantName,
              status: status,
            );
          },
    );
  }
}
