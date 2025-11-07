import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant/core/config/app_initializer.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_router.dart';
import 'package:merchant/core/themes/app_theme.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:merchant/features/profile/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:merchant/features/profile/presentation/cubits/noti_cubit/noti_cubit.dart';
import 'package:toastification/toastification.dart';

void main() async {
  await AppInitializer.init();
  runApp(ToastificationWrapper(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = sl<AppRouter>();
  final AuthBloc _authBloc = sl<AuthBloc>();
  final UserBloc _userBloc = sl<UserBloc>();
  final NotiCubit _notiCubit = sl<NotiCubit>();
  final LocaleCubit _locale = sl<LocaleCubit>();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => _authBloc..add(AuthEvent.checkAuthStatus()),
        ),
        BlocProvider(
          create: (context) => _userBloc..add(UserEvent.getUser()),
          child: Container(),
        ),
        BlocProvider(create: (context) => _locale..loadInitialLocale()),
        BlocProvider(create: (context) => _notiCubit..loadNoti()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,

        routerConfig: _appRouter.router,
      ),
    );
  }
}
