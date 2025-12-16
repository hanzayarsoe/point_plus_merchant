import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class UnregisterTokenUsecase {
  final ProfileRepository profileRepository;
  UnregisterTokenUsecase(this.profileRepository);
  TaskEither<Failure, void> call(String token) {
    return profileRepository.unregisterToken(token);
  }
}
