import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class TransferPointUsecase {
  final HomeRepository homeRepository;
  TransferPointUsecase(this.homeRepository);
  TaskEither<Failure, void> call(PointTransferEntity pointTransferEntity) {
    return homeRepository.transferPoint(pointTransferEntity);
  }
}
