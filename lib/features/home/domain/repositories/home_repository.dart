import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/customer_entity.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';

abstract interface class HomeRepository {
  TaskEither<Failure, void> transferPoint(
    PointTransferEntity pointTransferEntity,
  );
  TaskEither<Failure, CustomerEntity> searchCustomer(String accountNumber);
}
