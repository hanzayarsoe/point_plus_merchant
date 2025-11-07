import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class ConfirmPasswordUsecase {
  final ProfileRepository profileRepository;
  ConfirmPasswordUsecase(this.profileRepository);
  TaskEither<Failure, void> call(String password) {
    return profileRepository.confirmPassword(password);
  }
}
