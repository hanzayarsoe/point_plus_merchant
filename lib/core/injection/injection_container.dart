import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:merchant/core/constants/api_urls.dart';
import 'package:merchant/core/network/cubit/connection_cubit.dart';
import 'package:merchant/core/network/data/network_info_impl.dart';
import 'package:merchant/core/network/dio_helper.dart';
import 'package:merchant/core/network/domain/network_info.dart';
import 'package:merchant/core/storage/secure_storage.dart';
import 'package:merchant/core/storage/user_preference.dart';
import 'package:merchant/core/utils/device_info.dart';
import 'package:merchant/core/utils/helper_function.dart';
import 'package:merchant/core/utils/validation.dart';
import 'package:merchant/features/auth/di/auth_injection.dart';
import 'package:merchant/features/history/di/history_injection.dart';
import 'package:merchant/features/home/di/home_injection.dart';
import 'package:merchant/features/profile/di/profile_injection.dart';
import 'package:merchant/features/store/di/store_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> serviceLocater() async {
  sl.registerLazySingleton(() => navigatorKey);

  // Validator
  sl.registerLazySingleton<AppValidator>(() => AppValidator());

  // Helper Function
  sl.registerLazySingleton(() => HelperFunction());

  // Secure Storage
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());
  // Dio
  sl.registerLazySingleton(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        sendTimeout: Duration(seconds: 10),
      ),
    );
    return dio;
  });
  sl.registerLazySingleton(() => DioHelper(sl(), sl()));
  // Network
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerSingleton(ConnectionCubit(sl(), sl()));

  // Shared Preferences
  sl.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  // User Preferences
  sl.registerSingletonAsync<UserPreference>(() async {
    final prefs = await sl.getAsync<SharedPreferences>();
    // final fcm = FirebaseMessaging.instance;
    return UserPreference(prefs);
  }, dependsOn: [SharedPreferences]);

  // Device Info
  sl.registerLazySingleton(() => DeviceInfoPlugin());
  sl.registerLazySingleton<DeviceInfo>(() => DeviceInfo(sl()));

  // Auth
  AuthInjection.init(sl);

  // Home
  HomeInjection.init(sl);

  // Profile
  ProfileInjection.init(sl);

  // Store
  StoreInjection.init(sl);

  // History
  HistoryInjection.init(sl);
}
