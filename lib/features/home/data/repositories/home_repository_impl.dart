import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
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
}
