import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/data/models/history_list_item_model.dart';
import 'package:merchant/features/home/data/models/transaction_model.dart';

abstract interface class HistoryDatasource {
  TaskEither<Failure, List<HistoryListItemModel>> getHistories({
    required int page,
    required int limit,
    required HistoryTransactionType? type,
    required String? startDate,
    required String? endDate,
  });
  TaskEither<Failure, TransactionModel> getTransactionDetail(int id);
}
