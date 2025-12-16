import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/home/domain/repositories/home_repository.dart';

class GetUnreadCountUsecase {
  final HomeRepository homeRepository;
  GetUnreadCountUsecase(this.homeRepository);
  TaskEither<Failure, int> call() {
    return homeRepository.getUnreadCount();
  }
}
