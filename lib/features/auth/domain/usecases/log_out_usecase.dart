import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class LogOutUsecase {
  final AuthRepository authRepository;
  LogOutUsecase(this.authRepository);
  TaskEither<Failure, void> call() {
    return authRepository.logOut();
  }
}
