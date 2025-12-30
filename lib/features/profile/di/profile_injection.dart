import 'package:get_it/get_it.dart';
import 'package:merchant/features/profile/data/datasources/profile_datasource.dart';
import 'package:merchant/features/profile/data/datasources/profile_datasource_impl.dart';
import 'package:merchant/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:merchant/features/profile/domain/repositories/profile_repository.dart';
import 'package:merchant/features/profile/domain/usecases/change_locale_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/change_mobile_number_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/get_branch_info_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/get_devices_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/load_locale.dart';
import 'package:merchant/features/profile/domain/usecases/register_token_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/send_otp_to_change_number_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/unregister_token_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/update_branch_info_usecase.dart';
import 'package:merchant/features/profile/domain/usecases/update_manager_info_usecase.dart';
import 'package:merchant/features/profile/presentation/bloc/branch_bloc/branch_bloc.dart';
import 'package:merchant/features/profile/presentation/bloc/device_bloc/devices_bloc.dart';
import 'package:merchant/features/profile/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:merchant/features/profile/presentation/cubits/noti_cubit/noti_cubit.dart';

class ProfileInjection {
  ProfileInjection._();
  static void init(GetIt sl) {
    sl
      ..registerLazySingleton<ProfileDatasource>(
        () => ProfileDatasourceImpl(sl(), sl()),
      )
      ..registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => ChangeMobileNumberUsecase(sl()))
      ..registerLazySingleton(() => GetBranchInfoUsecase(sl()))
      ..registerLazySingleton(() => LoadLocaleUseCase(sl()))
      ..registerLazySingleton(() => SendOtpToChangeNumberUsecase(sl()))
      ..registerLazySingleton(() => UpdateBranchInfoUsecase(sl()))
      ..registerLazySingleton(() => ChangePasswordUsecase(sl()))
      ..registerLazySingleton(() => ChangeLocaleUseCase(sl()))
      ..registerLazySingleton(() => UpdateManagerInfoUsecase(sl()))
      ..registerLazySingleton(() => RegisterTokenUsecase(sl()))
      ..registerLazySingleton(() => UnregisterTokenUsecase(sl()))
      ..registerLazySingleton(() => GetDevicesUsecase(sl()))
      ..registerLazySingleton(() => LocaleCubit(sl(), sl()))
      ..registerLazySingleton(() => NotiCubit(sl(), sl(), sl(), sl()))
      ..registerFactory(() => DevicesBloc(sl()))
      ..registerLazySingleton(
        () => BranchBloc(sl(), sl(), sl(), sl(), sl(), sl()),
      );
  }
}
