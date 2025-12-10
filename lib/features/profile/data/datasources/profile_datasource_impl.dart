import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/storage/user_preference.dart';
import 'package:merchant/core/utils/task_either_helpers.dart';
import 'package:merchant/features/auth/data/models/branch_model.dart';
import 'package:merchant/features/auth/domain/entities/manager.dart';
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
  TaskEither<Failure, BranchModel> updateBranchInfo(BranchModel updatedBranch) {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.put(ApiUrls.editBranchInfo, {
        "name": updatedBranch.name,
        "secondaryPhoneNumber": updatedBranch.secondaryPhoneNumber,
        "openTime": updatedBranch.openTime,
        "closeTime": updatedBranch.closeTime,
        "branchAddress": updatedBranch.branchAddress,
      });

      final data = response.data['data'];
      return BranchModel.fromJson(data);
    });
  }

  @override
  TaskEither<Failure, BranchModel> getBranchInfo() {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.get(ApiUrls.me, {});
      final data = response.data['data'];
      return BranchModel.fromJson(data);
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

  @override
  TaskEither<Failure, void> updateManagerInfo(Manager updatedManger) {
    return tryCatchWithFailure(() async {
      final formData = FormData.fromMap({
        "name": updatedManger.name,
        "email": updatedManger.email,
        "phoneNumber": updatedManger.phoneNumber,
        "address": updatedManger.address,
        "gender": updatedManger.gender!.toUpperCase(),
        "dob": updatedManger.dob,
      });

      if (updatedManger.profileUrl != null &&
          updatedManger.profileUrl!.isNotEmpty &&
          !updatedManger.profileUrl!.startsWith('http')) {
        formData.files.add(
          MapEntry(
            "profile",
            await MultipartFile.fromFile(updatedManger.profileUrl!),
          ),
        );
      }

      await dioHelper.put(ApiUrls.manager, formData);
    });
  }
}
