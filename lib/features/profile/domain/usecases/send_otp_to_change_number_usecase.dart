import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class SendOtpToChangeNumberUsecase {
  final ProfileRepository profileRepository;
  SendOtpToChangeNumberUsecase(this.profileRepository);
  TaskEither<Failure, void> call(String mobileNumber) {
    return profileRepository.sendOtpToChangeMobileNumber(mobileNumber);
  }
}
