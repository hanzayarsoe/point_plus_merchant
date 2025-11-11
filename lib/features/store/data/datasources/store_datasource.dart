import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/store/data/models/item_model.dart';

abstract interface class StoreDatasource {
  TaskEither<Failure, List<ItemModel>> getItems({
    required int page,
    required int limit,
    required int merchantId,
    required bool allItems,
    required bool promoItems,
  });
}
