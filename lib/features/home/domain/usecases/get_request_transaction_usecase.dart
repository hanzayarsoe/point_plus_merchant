import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class GetRequestTransactionUsecase {
  final HomeRepository homeRepository;
  GetRequestTransactionUsecase(this.homeRepository);
  TaskEither<Failure, List<HistoryListItemEntity>> call({
    required int page,
    required int limit,
    required RequestTransactionType? type,
    required String? startDate,
    required String? endDate,
  }) {
    return homeRepository.getRequestHistory(
      page,
      limit,
      type,
      startDate,
      endDate,
    );
  }
}
