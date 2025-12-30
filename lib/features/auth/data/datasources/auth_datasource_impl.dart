import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/storage/secure_storage.dart';
import 'package:merchant/core/utils/device_info.dart';
import 'package:merchant/core/utils/task_either_helpers.dart';
import 'package:merchant/features/auth/data/datasources/auth_datasource.dart';
import 'package:merchant/features/auth/data/models/branch_model.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final DioHelper dioHelper;
  final SecureStorage secureStorage;
  AuthDatasourceImpl(this.dioHelper, this.secureStorage);
  @override
  TaskEither<Failure, BranchModel> checkAuthStatus() {
    return tryCatchWithFailure(() async {
      final accessToken = await secureStorage.getAccessToken();
      if (accessToken == null) {
        throw Exception('token not found');
      }
      final response = await dioHelper.get(ApiUrls.me);
      final data = response.data['data'];
      return BranchModel.fromJson(data);
    });
  }

  @override
  TaskEither<Failure, void> logIn(String phone, String password) {
    return tryCatchWithFailure(() async {
      final deviceType = await sl<DeviceInfo>().getDeviceName();
      final response = await dioHelper.post(ApiUrls.logIn, {
        "phoneNumber": phone,
        "password": password,
        "deviceType": deviceType,
      });
      final String? accessToken =
          response.data['data']?['tokens']?['accessToken'];
      final String? refreshToken =
          response.data['data']?['tokens']?['refreshToken'];
      if (accessToken != null && refreshToken != null) {
        final secureStorage = sl<SecureStorage>();
        await secureStorage.saveTokens(accessToken, refreshToken);
      }
    });
  }

  @override
  TaskEither<Failure, void> logOut() {
    return tryCatchWithFailure(() async {
      final refreshToken = await secureStorage.getRefreshToken();
      await dioHelper.post(
        ApiUrls.logOut,
        {},
        queryParameters: {"refreshToken": refreshToken},
      );
    });
  }

  @override
  Future<void> forceLogOut() async {
    await secureStorage.deleteTokens();
  }

  @override
  TaskEither<Failure, void> resetPassword(
    String phoneNumber,
    String newPassword,
  ) {
    return tryCatchWithFailure(() async {
      await dioHelper.post(ApiUrls.forgetPasswordReset, {
        "identifier": phoneNumber,
        "password": newPassword,
      });
    });
  }

  @override
  TaskEither<Failure, void> sendOtp(String phoneNumber) {
    return tryCatchWithFailure(() async {
      await dioHelper.post(ApiUrls.forgetPasswordSendOtp, {
        "identifier": phoneNumber,
      });
    });
  }

  @override
  TaskEither<Failure, void> verifyOtp(String phoneNumber, String otp) {
    return tryCatchWithFailure(() async {
      await dioHelper.post(ApiUrls.forgetPasswordVerifyOtp, {
        "identifier": phoneNumber,
        "otp": otp,
      });
    });
  }

  @override
  TaskEither<Failure, BranchModel> refreshUser() {
    return tryCatchWithFailure(() async {
      final response = await dioHelper.get(ApiUrls.me);
      final data = response.data['data'];
      return BranchModel.fromJson(data);
    });
  }
}
