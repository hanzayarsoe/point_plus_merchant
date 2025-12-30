import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class UpdateBranchInfoUsecase {
  final ProfileRepository profileRepository;
  UpdateBranchInfoUsecase(this.profileRepository);
  TaskEither<Failure, Branch> call(Branch updatedBranch) {
    return profileRepository.updateBranchInfo(updatedBranch);
  }
}
