import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/point_request_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class GetRequestHistoriesUsecase {
  final HomeRepository homeRepository;
  GetRequestHistoriesUsecase(this.homeRepository);
  TaskEither<Failure, List<PointRequestEntity>> call({
    required int page,
    required int limit,
    required String? startDate,
    required String? endDate,
    required RequestTransactionType requestType,
  }) {
    return homeRepository.getRequestHistory(
      page,
      limit,
      requestType,
      startDate,
      endDate,
    );
  }
}
