import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/home/domain/entities/transaction_entity.dart';

abstract interface class HistoryRepository {
  TaskEither<Failure, List<HistoryListItemEntity>> getHistories({
    required int page,
    required int limit,
    required HistoryTransactionType? type,
    required String? startDate,
    required String? endDate,
  });
  TaskEither<Failure, TransactionEntity> getTransactionDetail(int id);
}
