import 'package:get_it/get_it.dart';
import 'package:merchant/core/router/app_router.dart';
import 'package:merchant/features/auth/data/datasources/auth_datasource.dart';
import 'package:merchant/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:merchant/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:merchant/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/force_log_out_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/refresh_user_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:merchant/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

class AuthInjection {
  AuthInjection._();

  static void init(GetIt sl) {
    // -- datasource --
    sl.registerLazySingleton<AuthDatasource>(
      () => AuthDatasourceImpl(sl(), sl()),
    );

    // -- domain --
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

    sl.registerLazySingleton(() => CheckAuthStatusUsecase(sl()));
    sl.registerLazySingleton(() => LogInUsecase(sl()));
    sl.registerLazySingleton(() => LogOutUsecase(sl()));
    sl.registerLazySingleton(() => ForceLogOutUsecase(sl()));
    sl.registerLazySingleton(() => SendOtpUsecase(sl()));
    sl.registerLazySingleton(() => VerifyOtpUsecase(sl()));
    sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
    sl.registerLazySingleton(() => RefreshUserUsecase(sl()));

    // -- presentation --
    sl.registerLazySingleton(
      () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
    );

    // -- Router --
    sl.registerLazySingleton(() => AppRouter(sl()));
  }
}
