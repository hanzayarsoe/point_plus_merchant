import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
import 'package:merchant/features/profile/domain/usecases/change_mobile_number_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/send_otp_to_change_number_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/update_user_info_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUsecase getUserUsecase;
  final UpdateUserInfoUsecase updateUserInfoUsecase;
  final SendOtpToChangeNumberUsecase sendOtpToChangeNumberUsecase;
  final ChangeMobileNumberUsecase changeMobileNumberUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  UserBloc(
    this.getUserUsecase,
    this.updateUserInfoUsecase,
    this.sendOtpToChangeNumberUsecase,
    this.changeMobileNumberUsecase,
    this.changePasswordUsecase,
  ) : super(_Initial()) {
    on<_GetUser>(_onGetUser);
    on<_UpdateUserInfo>(_onUpdateUseInfo);
    on<_SendOtpToChangeNumber>(_onSendOtpToChangeNumber);
    on<_ChangeMobileNumber>(_onChangeMobileNumber);
    on<_ChangePassword>(_onChangePassword);
  }
  Future<void> _onGetUser(_GetUser event, Emitter<UserState> emit) async {
    emit(UserState.loading());
    final result = await getUserUsecase.call().run();
    result.fold(
      (failure) => emit(UserState.failedToLoadUser(failure)),
      (user) => emit(UserState.loadedUser(user)),
    );
  }

  Future<void> _onUpdateUseInfo(
    _UpdateUserInfo event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState.loading());
    final result = await updateUserInfoUsecase
        .call(event.updatedUser, event.profileImage)
        .run();
    result.fold(
      (failure) => emit(UserState.updateUserFailed(failure)),
      (updatedUser) => emit(UserState.updateUserSuccessed(updatedUser)),
    );
  }

  Future<void> _onSendOtpToChangeNumber(
    _SendOtpToChangeNumber event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState.loading());
    final result = await sendOtpToChangeNumberUsecase
        .call(event.mobileNumber)
        .run();
    result.fold(
      (failure) => emit(UserState.sentOtpFailed(failure)),
      (_) => emit(UserState.sentOtpSuccessed()),
    );
  }

  Future<void> _onChangeMobileNumber(
    _ChangeMobileNumber event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState.loading());
    final result = await changeMobileNumberUsecase
        .call(event.number, event.otp)
        .run();
    result.fold(
      (failure) => emit(UserState.changeMobileNumberFailed(failure)),
      (_) => emit(UserState.changeMobileNumberSuccessed()),
    );
  }

  Future<void> _onChangePassword(
    _ChangePassword event,
    Emitter<UserState> emit,
  ) async {
    emit(UserState.loading());
    final result = await changePasswordUsecase
        .call(event.currentPassword, event.newPassword)
        .run();
    result.fold(
      (failure) => emit(UserState.changePasswordFailed(failure)),
      (_) => emit(UserState.changePasswordSuccessed()),
    );
  }
}
