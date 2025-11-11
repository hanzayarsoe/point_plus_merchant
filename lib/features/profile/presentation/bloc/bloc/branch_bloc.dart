import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/profile/domain/usecases/change_mobile_number_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/get_branch_info_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/send_otp_to_change_number_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/update_branch_info_usecase.dart';

part 'branch_event.dart';
part 'branch_state.dart';
part 'branch_bloc.freezed.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final GetBranchInfoUsecase getBranchInfoUsecase;
  final UpdateBranchInfoUsecase updateBranchInfoUsecase;
  final SendOtpToChangeNumberUsecase sendOtpToChangeNumberUsecase;
  final ChangeMobileNumberUsecase changeMobileNumberUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  BranchBloc(
    this.getBranchInfoUsecase,
    this.updateBranchInfoUsecase,
    this.sendOtpToChangeNumberUsecase,
    this.changeMobileNumberUsecase,
    this.changePasswordUsecase,
  ) : super(_Initial()) {
    on<_GetBranchInfo>(_onGetBranchInfo);
    on<_UpdateBranchInfo>(_onUpdateBranchInfo);
    on<_SendOtpToChangeNumber>(_onSendOtpToChangeNumber);
    on<_ChangeMobileNumber>(_onChangeMobileNumber);
    on<_ChangePassword>(_onChangePassword);
    on<_RefreshBranchData>(_onRefreshBranchData);
  }
  Future<void> _onGetBranchInfo(
    _GetBranchInfo event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchState.loading());
    final result = await getBranchInfoUsecase.call().run();
    result.fold(
      (failure) => emit(BranchState.failedToLoadBranch(failure)),
      (user) => emit(BranchState.loadedBranch(user)),
    );
  }

  Future<void> _onUpdateBranchInfo(
    _UpdateBranchInfo event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchState.loading());
    final result = await updateBranchInfoUsecase
        .call(event.updatedBranch)
        .run();
    result.fold(
      (failure) => emit(BranchState.updateBranchFailed(failure)),
      (updatedUser) => emit(BranchState.updateBranchSuccessed(updatedUser)),
    );
  }

  Future<void> _onSendOtpToChangeNumber(
    _SendOtpToChangeNumber event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchState.loading());
    final result = await sendOtpToChangeNumberUsecase
        .call(event.mobileNumber)
        .run();
    result.fold(
      (failure) => emit(BranchState.sentOtpFailed(failure)),
      (_) => emit(BranchState.sentOtpSuccessed()),
    );
  }

  Future<void> _onChangeMobileNumber(
    _ChangeMobileNumber event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchState.loading());
    final result = await changeMobileNumberUsecase
        .call(event.number, event.otp)
        .run();
    result.fold(
      (failure) => emit(BranchState.changeMobileNumberFailed(failure)),
      (_) => emit(BranchState.changeMobileNumberSuccessed()),
    );
  }

  Future<void> _onChangePassword(
    _ChangePassword event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchState.loading());
    final result = await changePasswordUsecase
        .call(event.currentPassword, event.newPassword)
        .run();
    result.fold(
      (failure) => emit(BranchState.changePasswordFailed(failure)),
      (_) => emit(BranchState.changePasswordSuccessed()),
    );
  }

  Future<void> _onRefreshBranchData(
    _RefreshBranchData event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchState.loading());
    add(BranchEvent.getBranchInfo());
  }
}
