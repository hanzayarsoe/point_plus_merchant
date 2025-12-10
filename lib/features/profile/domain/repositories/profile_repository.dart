import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';

abstract interface class ProfileRepository {
  Future<String> loadLocale();
  Future<void> changeLocale(Locale locale);
  TaskEither<Failure, Branch> updateBranchInfo(Branch branch);

  TaskEither<Failure, Branch> getBranchInfo();
  TaskEither<Failure, void> sendOtpToChangeMobileNumber(String mobileNumber);
  TaskEither<Failure, void> changeMobileNumber(String number, String otp);
  TaskEither<Failure, void> confirmPassword(String password);
  TaskEither<Failure, void> changePassword(
    String currentPassword,
    String newPassword,
  );
  TaskEither<Failure, void> updateManagerInfo(Manager updatedManager);
}
