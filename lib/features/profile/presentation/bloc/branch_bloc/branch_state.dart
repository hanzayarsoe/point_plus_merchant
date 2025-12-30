part of 'branch_bloc.dart';

@freezed
class BranchState with _$BranchState {
  const factory BranchState.initial() = _Initial;
  const factory BranchState.loading() = _Loading;
  const factory BranchState.loadedBranch(Branch branch) = _LoadedBranch;
  const factory BranchState.failedToLoadBranch(Failure failure) =
      _FailedToLoadBranch;
  const factory BranchState.updateBranchSuccessed(Branch updatedBranch) =
      _UpdateBranchSuccessed;
  const factory BranchState.updateBranchFailed(Failure failure) =
      _UpdateBranchFailed;
  const factory BranchState.sentOtpSuccessed() = _SentOtpSuccessed;
  const factory BranchState.sentOtpFailed(Failure failure) = _SentOtpFailed;
  const factory BranchState.changeMobileNumberSuccessed() =
      _ChangeMobileNumberSuccessed;
  const factory BranchState.changeMobileNumberFailed(Failure failure) =
      _ChangeMobileNumberFailed;
  const factory BranchState.changePasswordSuccessed() =
      _ChangePasswordSuccessed;
  const factory BranchState.changePasswordFailed(Failure failure) =
      _ChangePasswordFailed;
  const factory BranchState.updatedManagerSuccessful() =
      _UpdateManagerSuccessful;
  const factory BranchState.updatedManagerFailed(Failure failure) =
      _UpdatedManagerFailed;
}
