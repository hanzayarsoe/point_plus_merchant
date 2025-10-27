import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository authRepository;
  ResetPasswordUsecase(this.authRepository);
  TaskEither<Failure, void> call(String phoneNumber, String newPassword) {
    return authRepository.resetPassword(phoneNumber, newPassword);
  }
}
