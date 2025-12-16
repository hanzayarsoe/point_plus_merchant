import 'package:freezed_annotation/freezed_annotation.dart';

part 'noti_entity.freezed.dart';

@Freezed(unionKey: 'type')
abstract class NotiEntity with _$NotiEntity {
  @FreezedUnionValue('dateHeader')
  const factory NotiEntity.dateHeader({required String groupTitle}) =
      NotiDateHeader;

  @FreezedUnionValue('notification')
  const factory NotiEntity.notification({
    required int id,
    required String? title,
    required String? message,
    required String? notificationType,
    required bool read,
    required DateTime createdAt,
    required NotiDataEntity? data,
  }) = NotiItem;
}

@freezed
abstract class NotiDataEntity with _$NotiDataEntity {
  const NotiDataEntity._();
  const factory NotiDataEntity({
    required String? type,
    required String? action,
    required String? message,
    required int? requestId,
    required String? merchantName,
    required String? merchantPfUrl,
    required num? amount,
    required String? transactionId,
    required String? customerName,
    required String? customerAccount,
  }) = _NotiDataEntity;
  String? get navigationId {
    if (requestId != null) {
      return requestId.toString();
    }
    if (transactionId != null && transactionId!.isNotEmpty) {
      return transactionId;
    }
    return null;
  }
}
