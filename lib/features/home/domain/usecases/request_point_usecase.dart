import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class RequestPointUsecase {
  final HomeRepository homeRepository;
  RequestPointUsecase(this.homeRepository);
  TaskEither<Failure, void> call({
    required int points,
    required RequestTransactionType type,
  }) {
    return homeRepository.requestPoints(type, points);
  }
}
