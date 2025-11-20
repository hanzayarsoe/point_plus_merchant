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
  const factory NotiDataEntity({
    required String? type,
    required String? action,
    required String? message,
    required int? requestId,
    required String? merchantName,
    required String? merchantPfUrl,
  }) = _NotiDataEntity;
}

// {
//     "success": true,
//     "message": "Fetched notifications",
//     "data": {
//         "unreadCount": 21,
//         "items": [
//             {
//                 "groupTitle": "Nov 20 2025",
//                 "type": "dateHeader"
//             },
//             {
//                 "id": 71,
//                 "title": "Point Request Rejected by Merchant",
//                 "message": "Point Request Rejected by Merchant",
//                 "notificationType": "UNREADABLE",
//                 "data": {
//                     "type": "RECHARGE",
//                     "action": "MERCHANT_REJECTED",
//                     "message": "has rejected to recharge 2,450 points",
//                     "requestId": 60,
//                     "merchantName": "Digital Base Main",
//                     "merchantPfUrl": "/uploads/users/merchants/a3d8903d-c4e2-42b9-9f59-4021cf524f1d.jpg"
//                 },
//                 "read": false,
//                 "createdAt": "2025-11-20T11:42:06Z",
//                 "type": "notification"
//             },
