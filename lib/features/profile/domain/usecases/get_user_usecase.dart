import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class GetUserUsecase {
  final ProfileRepository profileRepository;
  GetUserUsecase(this.profileRepository);
  TaskEither<Failure, User> call() {
    return profileRepository.getUser();
  }
}
