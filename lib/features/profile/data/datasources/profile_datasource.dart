import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/data/models/user_model.dart';

abstract interface class ProfileDatasource {
  Future<String> loadLocale();
  Future<void> changeLocale(Locale locale);
  TaskEither<Failure, UserModel> updateUserProfile(
    UserModel user,
    File? profileImage,
  );
  TaskEither<Failure, UserModel> getUser();
  TaskEither<Failure, void> sendOtpToChangeNumber(String mobileNumber);
  TaskEither<Failure, void> changeMobileNumber(String number, String otp);
  TaskEither<Failure, void> confirmPassword(String password);
  TaskEither<Failure, void> changePassword(
    String currentPassword,
    String newPassword,
  );
}
