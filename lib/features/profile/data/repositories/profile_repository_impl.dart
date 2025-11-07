import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/data/models/user_model.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
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
  TaskEither<Failure, User> updateUserProfile(User user, File? profileImage) {
    return profileDatasource
        .updateUserProfile(user.toModel(), profileImage)
        .map((model) => model.toEntity());
  }

  @override
  TaskEither<Failure, User> getUser() {
    return profileDatasource.getUser().map((user) => user.toEntity());
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
}
