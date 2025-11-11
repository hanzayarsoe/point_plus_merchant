import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class GetBranchInfoUsecase {
  final ProfileRepository profileRepository;
  GetBranchInfoUsecase(this.profileRepository);
  TaskEither<Failure, Branch> call() {
    return profileRepository.getBranchInfo();
  }
}
