import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/domain/repositories/store_repository.dart';

class GetItemsUsecase {
  final StoreRepository storeRepository;
  GetItemsUsecase(this.storeRepository);
  TaskEither<Failure, List<ItemEntity>> call({
    required int page,
    required int limit,
    required int merchantId,
    required bool allItems,
    required bool promoItems,
  }) {
    return storeRepository.getItems(
      page: page,
      limit: limit,
      merchantId: merchantId,
      allItems: allItems,
      promoItems: promoItems,
    );
  }
}
