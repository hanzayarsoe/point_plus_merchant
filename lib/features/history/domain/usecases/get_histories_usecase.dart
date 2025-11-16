import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/history/domain/repositories/history_repository.dart';

class GetHistoriesUsecase {
  final HistoryRepository historyRepository;
  GetHistoriesUsecase(this.historyRepository);
  TaskEither<Failure, List<HistoryListItemEntity>> call({
    required int page,
    required int limit,
    required HistoryTransactionType? type,
    required String? startDate,
    required String? endDate,
  }) {
    return historyRepository.getHistories(
      page: page,
      limit: limit,
      type: type,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
