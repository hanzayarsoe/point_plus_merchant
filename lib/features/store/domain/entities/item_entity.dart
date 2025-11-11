import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_entity.freezed.dart';

@freezed
abstract class ItemEntity with _$ItemEntity {
  const factory ItemEntity({
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
  }) = _ItemEntity;
}
