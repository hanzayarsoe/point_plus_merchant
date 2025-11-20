import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/utils/task_either_helpers.dart';
import 'package:merchant/features/history/data/datasources/history_datasource.dart';
import 'package:merchant/features/history/data/models/history_list_item_model.dart';
import 'package:merchant/features/home/data/models/transaction_model.dart';

class HistoryDatasourceImpl implements HistoryDatasource {
  final DioHelper dioHelper;
  HistoryDatasourceImpl(this.dioHelper);

  @override
  TaskEither<Failure, List<HistoryListItemModel>> getHistories({
    required int page,
    required int limit,
    required HistoryTransactionType? type,
    required String? startDate,
    required String? endDate,
  }) {
    return tryCatchWithFailure(() async {
      final String? apiType = switch (type) {
        HistoryTransactionType.inflow => 'earning',
        HistoryTransactionType.outflow => 'redemption',
        HistoryTransactionType.pointsflow => 'point_flow',
        HistoryTransactionType.all => null,
        null => null,
      };
      final response = await dioHelper.get(
        ApiUrls.historyTransaction,
        {},
        queryParameters: {
          "page": page,
          "size": limit,
          if (apiType != null && apiType.isNotEmpty) "type": apiType,
          if (startDate != null && startDate.isNotEmpty) "startDate": startDate,
          if (endDate != null && endDate.isNotEmpty) "endDate": endDate,
        },
      );
      final List<dynamic> data = response.data['data']['items'];
      return data
          .map((transaction) => HistoryListItemModel.fromJson(transaction))
          .toList();
    });
  }

  @override
  TaskEither<Failure, TransactionModel> getTransactionDetail(int id) {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.get(
        ApiUrls.transactionDetail.replaceFirst('{id}', id.toString()),
        {},
      );
      final data = response.data['data'];
      return TransactionModel.fromJson(data);
    });
  }
}
