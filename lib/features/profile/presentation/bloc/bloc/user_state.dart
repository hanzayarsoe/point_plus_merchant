part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loadedUser(User user) = _loadedUser;
  const factory UserState.failedToLoadUser(Failure failure) = _FailedToLoadUser;
  const factory UserState.updateUserSuccessed(User updatedUser) =
      _UpdateUserSuccessed;
  const factory UserState.updateUserFailed(Failure failure) = _UpdateUserFailed;
  const factory UserState.sentOtpSuccessed() = _SentOtpSuccessed;
  const factory UserState.sentOtpFailed(Failure failure) = _SentOtpFailed;
  const factory UserState.changeMobileNumberSuccessed() =
      _ChangeMobileNumberSuccessed;
  const factory UserState.changeMobileNumberFailed(Failure failure) =
      _ChangeMobileNumberFailed;
  const factory UserState.changePasswordSuccessed() = _ChangePasswordSuccessed;
  const factory UserState.changePasswordFailed(Failure failure) =
      _ChangePasswordFailed;
}
