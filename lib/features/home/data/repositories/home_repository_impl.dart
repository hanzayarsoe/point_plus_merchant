import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/history/data/models/history_list_item_model.dart';
import 'package:merchant/features/history/domain/entities/history_list_item_entity.dart';
import 'package:merchant/features/home/data/datasources/home_datasource.dart';
import 'package:merchant/features/home/data/models/customer_model.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource homeDatasource;
  HomeRepositoryImpl(this.homeDatasource);
  @override
  TaskEither<Failure, void> transferPoint(
    PointTransferEntity pointTransferEntity,
  ) {
    return homeDatasource.transferPoints(pointTransferEntity);
  }

  @override
  TaskEither<Failure, CustomerEntity> searchCustomer(String accountNumber) {
    return homeDatasource
        .searchCustomer(accountNumber)
        .map((customer) => customer.toEntity());
  }

  @override
  TaskEither<Failure, List<HistoryListItemEntity>> getRequestHistory(
    int page,
    int limit,
    RequestTransactionType? type,
    String? startDate,
    String? endDate,
  ) {
    return homeDatasource
        .getRequestHistories(page, limit, type, startDate, endDate)
        .map((items) => items.map((item) => item.toEntity()).toList());
  }
}
