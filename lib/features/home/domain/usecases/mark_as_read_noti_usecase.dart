import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class MarkAsReadNotiUsecase {
  final HomeRepository homeRepository;
  MarkAsReadNotiUsecase(this.homeRepository);
  TaskEither<Failure, void> call(String notiId) {
    return homeRepository.markAsRead(notiId);
  }
}
