import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserInfoUsecase {
  final ProfileRepository profileRepository;
  UpdateUserInfoUsecase(this.profileRepository);
  TaskEither<Failure, User> call(User user, File? profileImage) {
    return profileRepository.updateUserProfile(user, profileImage);
  }
}
