import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/store/data/datasources/store_datasource.dart';
import 'package:merchant/features/store/data/models/item_model.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreDatasource storeDatasource;
  StoreRepositoryImpl(this.storeDatasource);

  @override
  TaskEither<Failure, List<ItemEntity>> getItems({
    required int page,
    required int limit,
    required int merchantId,
    required bool allItems,
    required bool promoItems,
  }) {
    return storeDatasource
        .getItems(
          page: page,
          limit: limit,
          merchantId: merchantId,
          allItems: allItems,
          promoItems: promoItems,
        )
        .map((items) => items.map((item) => item.toEntity()).toList());
  }
}
