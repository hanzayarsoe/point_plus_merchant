import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
part 'point_transfer_model.freezed.dart';
part 'point_transfer_model.g.dart';

@freezed
abstract class PointTransferModel with _$PointTransferModel {
  const factory PointTransferModel({
    required String phoneNumber,
    required String name,
    required String? profileUrl,
    int? amount,
    String? customerQrCode,
    required String type,
  }) = _PointTransferModel;

  factory PointTransferModel.fromJson(Map<String, dynamic> json) =>
      _$PointTransferModelFromJson(json);
}

extension PointTransferModelX on PointTransferModel {
  PointTransferEntity toEntity() {
    return PointTransferEntity(
      phoneNumber: phoneNumber,
      name: name,
      profileUrl: profileUrl,
      amount: amount.toString(),
      customerQrCode: customerQrCode,
      type: type,
    );
  }
}
