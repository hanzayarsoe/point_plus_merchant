import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/data/models/user_model.dart';

abstract interface class AuthDatasource {
  TaskEither<Failure, UserModel> checkAuthStatus();
  TaskEither<Failure, void> logIn(String phone, String password);
  TaskEither<Failure, void> logOut();
  Future<void> forceLogOut();
  TaskEither<Failure, void> sendOtp(String phoneNumber);
  TaskEither<Failure, void> verifyOtp(String phoneNumber, String otp);
  TaskEither<Failure, void> resetPassword(
    String phoneNumber,
    String newPassword,
  );
  TaskEither<Failure, UserModel> refreshUser();
}
