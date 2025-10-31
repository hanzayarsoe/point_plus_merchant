import 'package:freezed_annotation/freezed_annotation.dart';
part 'point_transfer_entity.freezed.dart';

@freezed
abstract class PointTransferEntity with _$PointTransferEntity {
  const factory PointTransferEntity({
    required String accountNumber,
    required String name,
    required String? profileUrl,
    String? amount,
    String? customerQrCode,
    required String type,
  }) = _PointTransfer;
}
