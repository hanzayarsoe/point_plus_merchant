import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/data/models/branch_model.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';

abstract interface class ProfileDatasource {
  Future<String> loadLocale();
  Future<void> changeLocale(Locale locale);
  TaskEither<Failure, BranchModel> updateBranchInfo(BranchModel updatedBranch);
  TaskEither<Failure, BranchModel> getBranchInfo();
  TaskEither<Failure, void> sendOtpToChangeNumber(String mobileNumber);
  TaskEither<Failure, void> changeMobileNumber(String number, String otp);
  TaskEither<Failure, void> confirmPassword(String password);
  TaskEither<Failure, void> changePassword(
    String currentPassword,
    String newPassword,
  );
  TaskEither<Failure, void> updateManagerInfo(Manager updatedManger);
}
