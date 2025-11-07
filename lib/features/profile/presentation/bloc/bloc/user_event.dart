part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.getUser() = _GetUser;
  const factory UserEvent.updateUserInfo(User updatedUser, File? profileImage) =
      _UpdateUserInfo;
  const factory UserEvent.sendOtpToChangeNumber(String mobileNumber) =
      _SendOtpToChangeNumber;
  const factory UserEvent.changeMobileNumber(String number, String otp) =
      _ChangeMobileNumber;
  const factory UserEvent.changePassword(
    String currentPassword,
    String newPassword,
  ) = _ChangePassword;
}
