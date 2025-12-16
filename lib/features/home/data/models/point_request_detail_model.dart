import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/home/domain/entities/point_request_detail_entity.dart';

part 'point_request_detail_model.freezed.dart';
part 'point_request_detail_model.g.dart';

@freezed
abstract class PointRequestDetailModel with _$PointRequestDetailModel {
  const factory PointRequestDetailModel({
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
  }) = _PointRequestDetailModel;

  factory PointRequestDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PointRequestDetailModelFromJson(json);
}

extension PointRequestDetailModelX on PointRequestDetailModel {
  PointRequestDetailEntity toEntity() {
    return PointRequestDetailEntity(
      id: id,
      branchId: branchId,
      branchName: branchName,
      merchantId: merchantId,
      merchantName: merchantName,
      merchantProfile: merchantProfile,
      type: type,
      status: status,
      note: note,
      amount: amount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
