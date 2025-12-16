import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/data/datasources/home_datasource.dart';
import 'package:merchant/features/home/data/models/customer_model.dart';
import 'package:merchant/features/home/data/models/noti_model.dart';
import 'package:merchant/features/home/data/models/point_request_detail_model.dart';
import 'package:merchant/features/home/data/models/point_request_model.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';
import 'package:merchant/features/home/domain/entities/noti_entity.dart';
import 'package:merchant/features/home/domain/entities/point_request_detail_entity.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';
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
  TaskEither<Failure, List<PointRequestEntity>> getRequestHistory(
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

  @override
  TaskEither<Failure, void> requestPoints(
    RequestTransactionType type,
    int points,
  ) {
    return homeDatasource.requestPoints(points, type);
  }

  @override
  TaskEither<Failure, PointRequestDetailEntity> getRequestDetail(int id) {
    return homeDatasource.getRequestDetail(id).map((item) => item.toEntity());
  }

  @override
  TaskEither<Failure, List<NotiEntity>> getNotifs({
    required int page,
    required int limit,
  }) {
    return homeDatasource
        .getNotifs(page, limit)
        .map((notifs) => notifs.map((noti) => noti.toEntity()).toList());
  }

  @override
  TaskEither<Failure, int> getUnreadCount() {
    return homeDatasource.getUnreadCount();
  }

  @override
  TaskEither<Failure, void> markAsRead(String notiId) {
    return homeDatasource.markAsRead(notiId);
  }
}
