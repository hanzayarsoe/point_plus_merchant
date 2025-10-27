part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _UnAuthenticated;
  const factory AuthState.failure(Failure failure) = _Failure;
  const factory AuthState.sentOtpSuccessed() = _SentOtpSuccess;
  const factory AuthState.sentOtpFailed(Failure failure) = _SentOptFailed;
  const factory AuthState.verfiyOtpSuccessed() = _VerifyOtpSuccessed;
  const factory AuthState.verifyOtpFailed(Failure failure) = _VerifyOtpFailed;
  const factory AuthState.resetPasswordSuccessed() = _ResetPasswordSuccessed;
  const factory AuthState.resetPasswordFailed(Failure failure) =
      _ResetPasswordFailed;
}
