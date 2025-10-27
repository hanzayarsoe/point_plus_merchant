import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUsecase {
  final AuthRepository authRepository;
  CheckAuthStatusUsecase(this.authRepository);

  TaskEither<Failure, User> call() {
    return authRepository.checkAuthStatus();
  }
}
