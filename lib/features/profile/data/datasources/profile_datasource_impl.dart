import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/storage/user_preference.dart';
import 'package:merchant/core/utils/task_either_helpers.dart';
import 'package:merchant/features/auth/data/models/user_model.dart';
import 'package:merchant/features/profile/data/datasources/profile_datasource.dart';

class ProfileDatasourceImpl implements ProfileDatasource {
  final UserPreference userPreference;
  final DioHelper dioHelper;
  ProfileDatasourceImpl(this.userPreference, this.dioHelper);
  @override
  Future<void> changeLocale(Locale locale) async {
    await userPreference.setLanguageCode(locale.languageCode);
  }

  @override
  Future<String> loadLocale() async {
    return userPreference.getLanguageCode();
  }

  @override
  TaskEither<Failure, UserModel> updateUserProfile(
    UserModel user,
    File? profileImage,
  ) {
    return tryCatchWithFailure(() async {
      final formData = FormData();
      formData.fields.addAll([
        MapEntry('name', user.name),
        MapEntry('email', user.email ?? ''),
        MapEntry('phoneNumber', user.manager.phoneNumber ?? ''),
        MapEntry('address', user.manager.address ?? ''),
        MapEntry('dob', user.manager.dob ?? ''),
        MapEntry('gender', user.manager.gender!.toUpperCase()),
      ]);
      if (profileImage != null) {
        final fileName = profileImage.path.split('/').last;
        formData.files.add(
          MapEntry(
            'profileUrl',
            await MultipartFile.fromFile(profileImage.path, filename: fileName),
          ),
        );
      }
      final response = await dioHelper.put(ApiUrls.me, formData);
      final data = response.data['data'];
      return UserModel.fromJson(data);
    });
  }

  @override
  TaskEither<Failure, UserModel> getUser() {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.get(ApiUrls.me, {});
      final data = response.data['data'];
      return UserModel.fromJson(data);
    });
  }

  @override
  TaskEither<Failure, void> sendOtpToChangeNumber(String mobileNumber) {
    return tryCatchWithFailure(() async {
      await dioHelper.post(ApiUrls.changeMobileNumberSendOtp, {
        "identifier": mobileNumber,
      });
    });
  }

  @override
  TaskEither<Failure, void> changeMobileNumber(String number, String otp) {
    return tryCatchWithFailure(() async {
      await dioHelper.put(ApiUrls.changeMobileNumber, {
        "phoneNumber": number,
        "otp": otp,
      });
    });
  }

  @override
  TaskEither<Failure, void> confirmPassword(String password) {
    return tryCatchWithFailure(() async {
      // await dioHelper.get(ApiUrls.confrimPassword, {"password": password});
    });
  }

  @override
  TaskEither<Failure, void> changePassword(
    String currentPassword,
    String newPassword,
  ) {
    return tryCatchWithFailure(() async {
      await dioHelper.patch(ApiUrls.changePassword, {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
      });
    });
  }
}
