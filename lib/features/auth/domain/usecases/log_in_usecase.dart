import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class LogInUsecase {
  final AuthRepository authRepository;
  LogInUsecase(this.authRepository);
  TaskEither<Failure, void> call(String phone, String password) {
    return authRepository.logIn(phone, password);
  }
}
