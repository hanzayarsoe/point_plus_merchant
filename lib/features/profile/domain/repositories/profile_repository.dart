import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';

abstract interface class ProfileRepository {
  Future<String> loadLocale();
  Future<void> changeLocale(Locale locale);
  TaskEither<Failure, User> updateUserProfile(User user, File? profileImage);
  TaskEither<Failure, User> getUser();
  TaskEither<Failure, void> sendOtpToChangeMobileNumber(String mobileNumber);
  TaskEither<Failure, void> changeMobileNumber(String number, String otp);
  TaskEither<Failure, void> confirmPassword(String password);
  TaskEither<Failure, void> changePassword(
    String currentPassword,
    String newPassword,
  );
}
