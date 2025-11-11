import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
abstract class ItemModel with _$ItemModel {
  const factory ItemModel({
    required int id,
    required String? name,
    required String? description,
    required int? requiredPoints,
    required int? promotionPoints,
    required String? itemImageUrl,
    required String? promoStartDate,
    required String? promoEndDate,
    required int merchantId,
    required String? merchantName,
    required List<String?>? promoAvailableBranches,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}

extension ItemModelX on ItemModel {
  ItemEntity toEntity() {
    return ItemEntity(
      id: id,
      name: name,
      description: description,
      requiredPoints: requiredPoints,
      promotionPoints: promotionPoints,
      itemImageUrl: itemImageUrl,
      promoStartDate: promoStartDate,
      promoEndDate: promoEndDate,
      merchantId: merchantId,
      merchantName: merchantName,
      promoAvailableBranches: promoAvailableBranches,
    );
  }
}
