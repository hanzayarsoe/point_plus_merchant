import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  TaskEither<Failure, User> checkAuthStatus();
  TaskEither<Failure, User> logIn(String phone, String password);
  TaskEither<Failure, void> logOut();
  Future<void> forceLogOut();
  TaskEither<Failure, void> sendOtp(String phoneNumber);
  TaskEither<Failure, void> verifyOtp(String phoneNumber, String otp);
  TaskEither<Failure, void> resetPassword(
    String phoneNumber,
    String newPassword,
  );
}
