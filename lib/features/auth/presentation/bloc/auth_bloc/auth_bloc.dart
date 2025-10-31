import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:merchant/core/failure/failure.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/features/auth/domain/entities/user.dart';
import 'package:merchant/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/force_log_out_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/refresh_user_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DioHelper _dioHelper;
  final CheckAuthStatusUsecase checkAuthStatusUsecase;
  final LogInUsecase logInUsecase;
  final LogOutUsecase logOutUsecase;
  final ForceLogOutUsecase forceLogOutUsecase;
  final SendOtpUsecase sendOtpUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final RefreshUserUsecase refreshUserUsecase;
  late final StreamSubscription _refreshFailedSub;
  late final StreamSubscription _refreshSucceededSub;
  AuthBloc(
    this._dioHelper,
    this.checkAuthStatusUsecase,
    this.logInUsecase,
    this.logOutUsecase,
    this.forceLogOutUsecase,
    this.sendOtpUsecase,
    this.verifyOtpUsecase,
    this.resetPasswordUsecase,
    this.refreshUserUsecase,
  ) : super(_Initial()) {
    _refreshFailedSub = _dioHelper.refreshFailedStream.listen((_) {
      add(AuthEvent.refreshFailed());
    });
    _refreshSucceededSub = _dioHelper.refreshSucceededStream.listen((_) {
      add(AuthEvent.refreshSucceeded());
    });

    on<_CheckAuthStatus>(_onCheckAuthStatus);
    on<_LogIn>(_onLogIn);
    on<_LogOut>(_onLogOut);
    on<_ForceLogOut>(_onForceLogOut);
    on<_RefreshFailed>(_onRefreshFailed);
    on<_RefreshSucceeded>(_onRefreshSucceeded);
    on<_SendOtp>(_onSendOtp);
    on<_VerifyOtp>(_onVerifyOtp);
    on<_ResetPassword>(_onResetPassword);
    on<_RefreshUser>(_onRefreshUser);
  }

  Future<void> _onCheckAuthStatus(
    _CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final result = await checkAuthStatusUsecase.call().run();
    result.fold(
      (failure) => emit(AuthState.unauthenticated()),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onLogIn(_LogIn event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    final result = await logInUsecase.call(event.phone, event.password).run();
    result.fold((failure) => emit(AuthState.failure(failure)), (user) {
      add(AuthEvent.checkAuthStatus());
    });
  }

  Future<void> _onLogOut(_LogOut event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    final result = await logOutUsecase.call().run();
    result.fold(
      (failure) => emit(AuthState.failure(failure)),
      (_) => emit(AuthState.unauthenticated()),
    );
  }

  Future<void> _onForceLogOut(
    _ForceLogOut event,
    Emitter<AuthState> emit,
  ) async {
    await forceLogOutUsecase.call();
    if (state is _Authenticated) {
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> _onRefreshFailed(
    _RefreshFailed event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! _UnAuthenticated) {
      emit(AuthState.unauthenticated());
    }
  }

  Future<void> _onRefreshSucceeded(
    _RefreshSucceeded event,
    Emitter<AuthState> emit,
  ) async {
    final result = await checkAuthStatusUsecase.call().run();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSendOtp(_SendOtp event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    final result = await sendOtpUsecase.call(event.phoneNumber).run();
    result.fold(
      (failure) => emit(AuthState.sentOtpFailed(failure)),
      (_) => emit(AuthState.sentOtpSuccessed()),
    );
  }

  Future<void> _onVerifyOtp(_VerifyOtp event, Emitter<AuthState> emit) async {
    emit(AuthState.loading());
    final result = await verifyOtpUsecase
        .call(event.phoneNumber, event.otp)
        .run();
    result.fold(
      (failure) => emit(AuthState.verifyOtpFailed(failure)),
      (_) => emit(AuthState.verfiyOtpSuccessed()),
    );
  }

  Future<void> _onResetPassword(
    _ResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final result = await resetPasswordUsecase
        .call(event.phoneNumber, event.newPassword)
        .run();
    result.fold(
      (failure) => emit(AuthState.resetPasswordFailed(failure)),
      (_) => emit(AuthState.resetPasswordSuccessed()),
    );
  }

  Future<void> _onRefreshUser(
    _RefreshUser event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());
    final result = await refreshUserUsecase.call().run();
    result.fold(
      (failure) => emit(AuthState.refreshUserFailed(failure)),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  @override
  Future<void> close() {
    _refreshFailedSub.cancel();
    _refreshSucceededSub.cancel();
    return super.close();
  }
}
