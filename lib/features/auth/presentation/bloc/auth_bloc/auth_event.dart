part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = _CheckAuthStatus;
  const factory AuthEvent.refreshFailed() = _RefreshFailed;
  const factory AuthEvent.refreshSucceeded() = _RefreshSucceeded;
  const factory AuthEvent.logIn(String phone, String password) = _LogIn;
  const factory AuthEvent.logOut() = _LogOut;
  const factory AuthEvent.forceLogOut() = _ForceLogOut;
  const factory AuthEvent.sendOtp(String phoneNumber) = _SendOtp;
  const factory AuthEvent.verifyOtp(String phoneNumber, String otp) =
      _VerifyOtp;
  const factory AuthEvent.resetPassword(
    String phoneNumber,
    String newPassword,
  ) = _ResetPassword;
  const factory AuthEvent.refreshUser() = _RefreshUser;
  const factory AuthEvent.updateUserData(User updatedUser) = _UpdateUserData;
}
