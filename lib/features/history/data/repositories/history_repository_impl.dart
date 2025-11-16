import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/data/datasources/history_datasource.dart';
import 'package:merchant/features/history/data/models/history_list_item_model.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/history/domain/repositories/history_repository.dart';
import 'package:merchant/features/home/data/models/transaction_model.dart';
import 'package:merchant/features/home/domain/entities/transaction_entity.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDatasource historyDatasource;
  HistoryRepositoryImpl(this.historyDatasource);

  @override
  TaskEither<Failure, List<HistoryListItemEntity>> getHistories({
    required int page,
    required int limit,
    required HistoryTransactionType? type,
    required String? startDate,
    required String? endDate,
  }) {
    return historyDatasource
        .getHistories(
          page: page,
          limit: limit,
          type: type,
          startDate: startDate,
          endDate: endDate,
        )
        .map((items) => items.map((item) => item.toEntity()).toList());
  }

  @override
  TaskEither<Failure, TransactionEntity> getTransactionDetail(int id) {
    return historyDatasource
        .getTransactionDetail(id)
        .map((model) => model.toEntity());
  }
}
