import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class ChangeMobileNumberUsecase {
  final ProfileRepository profileRepository;
  ChangeMobileNumberUsecase(this.profileRepository);
  TaskEither<Failure, void> call(String number, String otp) {
    return profileRepository.changeMobileNumber(number, otp);
  }
}
