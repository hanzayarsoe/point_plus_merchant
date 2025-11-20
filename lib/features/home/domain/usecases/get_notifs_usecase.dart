import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/entities/noti_entity.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class GetNotifsUsecase {
  final HomeRepository homeRepository;
  GetNotifsUsecase(this.homeRepository);
  TaskEither<Failure, List<NotiEntity>> call({
    required int page,
    required int limit,
  }) {
    return homeRepository.getNotifs(page: page, limit: limit);
  }
}
