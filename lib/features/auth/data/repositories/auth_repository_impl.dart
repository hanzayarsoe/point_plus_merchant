import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/data/datasources/auth_datasource.dart';
import 'package:merchant/features/auth/data/models/user_model.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImpl(this.authDatasource);
  @override
  TaskEither<Failure, User> checkAuthStatus() {
    return authDatasource.checkAuthStatus().map((user) => user.toEntity());
  }

  @override
  Future<void> forceLogOut() {
    return authDatasource.forceLogOut();
  }

  @override
  TaskEither<Failure, void> logIn(String phone, String password) {
    return authDatasource.logIn(phone, password);
  }

  @override
  TaskEither<Failure, void> logOut() {
    return authDatasource.logOut();
  }

  @override
  TaskEither<Failure, void> resetPassword(
    String phoneNumber,
    String newPassword,
  ) {
    return authDatasource.resetPassword(phoneNumber, newPassword);
  }

  @override
  TaskEither<Failure, void> sendOtp(String phoneNumber) {
    return authDatasource.sendOtp(phoneNumber);
  }

  @override
  TaskEither<Failure, void> verifyOtp(String phoneNumber, String otp) {
    return authDatasource.verifyOtp(phoneNumber, otp);
  }

  @override
  TaskEither<Failure, User> refreshUser() {
    return authDatasource.refreshUser().map((user) => user.toEntity());
  }
}
