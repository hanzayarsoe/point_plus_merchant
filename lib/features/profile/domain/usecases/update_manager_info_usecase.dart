import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class UpdateManagerInfoUsecase {
  final ProfileRepository profileRepository;
  UpdateManagerInfoUsecase(this.profileRepository);
  TaskEither<Failure, void> call(Manager updatedManager) {
    return profileRepository.updateManagerInfo(updatedManager);
  }
}
