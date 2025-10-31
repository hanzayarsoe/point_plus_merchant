import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/data/models/customer_model.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';

abstract interface class HomeDatasource {
  TaskEither<Failure, void> transferPoints(
    PointTransferEntity pointTransferEntity,
  );
  TaskEither<Failure, CustomerModel> searchCustomer(String accountNumber);
}
