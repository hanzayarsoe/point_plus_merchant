import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUsecase {
  final ProfileRepository profileRepository;
  ChangePasswordUsecase(this.profileRepository);

  TaskEither<Failure, void> call(String currentPassword, String newPassword) {
    return profileRepository.changePassword(currentPassword, newPassword);
  }
}
