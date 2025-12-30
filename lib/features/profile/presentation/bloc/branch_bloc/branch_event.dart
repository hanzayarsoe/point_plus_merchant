part of 'branch_bloc.dart';

@freezed
class BranchEvent with _$BranchEvent {
  const factory BranchEvent.getBranchInfo() = _GetBranchInfo;
  const factory BranchEvent.updateBranchInfo(Branch updatedBranch) =
      _UpdateBranchInfo;
  const factory BranchEvent.sendOtpToChangeNumber(String mobileNumber) =
      _SendOtpToChangeNumber;
  const factory BranchEvent.changeMobileNumber(String number, String otp) =
      _ChangeMobileNumber;
  const factory BranchEvent.changePassword(
    String currentPassword,
    String newPassword,
  ) = _ChangePassword;
  const factory BranchEvent.refreshBranchData() = _RefreshBranchData;
  const factory BranchEvent.updateManagerInfo(Manager updatedManager) =
      _UpdateManagerInfo;
}
