import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUsecase {
  final AuthRepository authRepository;
  CheckAuthStatusUsecase(this.authRepository);

  TaskEither<Failure, Branch> call() {
    return authRepository.checkAuthStatus();
  }
}
