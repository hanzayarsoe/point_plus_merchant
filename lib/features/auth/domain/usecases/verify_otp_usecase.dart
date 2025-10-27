import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUsecase {
  final AuthRepository authRepository;
  VerifyOtpUsecase(this.authRepository);
  TaskEither<Failure, void> call(String phoneNumber, String otp) {
    return authRepository.verifyOtp(phoneNumber, otp);
  }
}
