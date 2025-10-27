import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class ForceLogOutUsecase {
  final AuthRepository authRepository;
  ForceLogOutUsecase(this.authRepository);
  Future<void> call() {
    return authRepository.forceLogOut();
  }
}
