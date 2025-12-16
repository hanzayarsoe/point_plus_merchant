import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/data/models/branch_model.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';
import 'package:merchant/features/profile/data/datasources/profile_datasource.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource profileDatasource;
  ProfileRepositoryImpl(this.profileDatasource);
  @override
  Future<void> changeLocale(Locale locale) {
    return profileDatasource.changeLocale(locale);
  }

  @override
  Future<String> loadLocale() {
    return profileDatasource.loadLocale();
  }

  @override
  TaskEither<Failure, Branch> updateBranchInfo(Branch updatedBranch) {
    return profileDatasource
        .updateBranchInfo(updatedBranch.toModel())
        .map((model) => model.toEntity());
  }

  @override
  TaskEither<Failure, Branch> getBranchInfo() {
    return profileDatasource.getBranchInfo().map((user) => user.toEntity());
  }

  @override
  TaskEither<Failure, void> sendOtpToChangeMobileNumber(String mobileNumber) {
    return profileDatasource.sendOtpToChangeNumber(mobileNumber);
  }

  @override
  TaskEither<Failure, void> changeMobileNumber(String number, String otp) {
    return profileDatasource.changeMobileNumber(number, otp);
  }

  @override
  TaskEither<Failure, void> confirmPassword(String password) {
    return profileDatasource.confirmPassword(password);
  }

  @override
  TaskEither<Failure, void> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return profileDatasource.changePassword(currentPassword, newPassword);
  }

  @override
  TaskEither<Failure, void> updateManagerInfo(Manager updatedManger) {
    return profileDatasource.updateManagerInfo(updatedManger);
  }

  @override
  TaskEither<Failure, void> registerToken(String token) {
    return profileDatasource.registerToken(token);
  }

  @override
  TaskEither<Failure, void> unregisterToken(String token) {
    return profileDatasource.unregisterToken(token);
  }
}
