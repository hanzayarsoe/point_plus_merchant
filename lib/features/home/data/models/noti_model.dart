import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/home/domain/entities/noti_entity.dart';

part 'noti_model.freezed.dart';
part 'noti_model.g.dart';

@Freezed(unionKey: 'type')
abstract class NotiModel with _$NotiModel {
  @FreezedUnionValue('dateHeader')
  const factory NotiModel.dateHeader({required String groupTitle}) =
      NotiDateHeaderModel;

  @FreezedUnionValue('notification')
  const factory NotiModel.notification({
    required int id,
    required String? title,
    required String? message,
    required String? notificationType,
    required bool read,
    required DateTime createdAt,
    required NotiDataModel? data,
  }) = NotiItemModel;

  factory NotiModel.fromJson(Map<String, dynamic> json) =>
      _$NotiModelFromJson(json);
}

@freezed
abstract class NotiDataModel with _$NotiDataModel {
  const factory NotiDataModel({
    required String? type,
    required String? action,
    required String? message,
    required int? requestId,
    required String? merchantName,
    required String? merchantPfUrl,
    required String? txId,
    required num? amount,
    required String? customerAccount,
  }) = _NotiDataModel;

  factory NotiDataModel.fromJson(Map<String, dynamic> json) =>
      _$NotiDataModelFromJson(json);
}

extension NotiModelMapper on NotiModel {
  NotiEntity toEntity() {
    return map(
      dateHeader: (model) =>
          NotiEntity.dateHeader(groupTitle: model.groupTitle),
      notification: (model) => NotiEntity.notification(
        id: model.id,
        title: model.title,
        message: model.message,
        notificationType: model.notificationType,
        read: model.read,
        createdAt: model.createdAt,
        data: model.data?.toEntity(),
      ),
    );
  }
}

extension NotiDataModelMapper on NotiDataModel {
  NotiDataEntity toEntity() {
    return NotiDataEntity(
      type: type,
      action: action,
      message: message,
      requestId: requestId,
      merchantName: merchantName,
      merchantPfUrl: merchantPfUrl,
    );
  }
}
