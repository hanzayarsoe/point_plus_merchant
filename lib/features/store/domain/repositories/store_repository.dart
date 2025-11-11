import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';

abstract interface class StoreRepository {
  TaskEither<Failure, List<ItemEntity>> getItems({
    required int page,
    required int limit,
    required int merchantId,
    required bool allItems,
    required bool promoItems,
  });
}
