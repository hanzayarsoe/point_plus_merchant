import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class SendOtpUsecase {
  final AuthRepository authRepository;
  SendOtpUsecase(this.authRepository);

  TaskEither<Failure, void> call(String phoneNumber) {
    return authRepository.sendOtp(phoneNumber);
  }
}
