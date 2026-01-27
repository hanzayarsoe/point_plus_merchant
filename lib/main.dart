import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant/core/config/app_initializer.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_router.dart';
import 'package:merchant/core/themes/app_theme.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/history/presentation/cubit/cubit/history_filter_cubit.dart';
import 'package:merchant/features/home/presentation/cubits/noti_count_cubit/noti_count_cubit.dart';
import 'package:merchant/features/home/presentation/cubits/request_filter_cubit/cubit/request_filter_cubit.dart';
import 'package:merchant/features/profile/presentation/bloc/branch_bloc/branch_bloc.dart';
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
  final BranchBloc _branchBloc = sl<BranchBloc>();
  final NotiCubit _notiCubit = sl<NotiCubit>();
  final LocaleCubit _locale = sl<LocaleCubit>();
  final NotiCountCubit _notiCountCubit = sl<NotiCountCubit>();
  final HistoryFilterCubit _historyFilterCubit = sl<HistoryFilterCubit>();
  final RequestFilterCubit _requestFilterCubit = sl<RequestFilterCubit>();
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
          lazy: false,
          create: (context) => _branchBloc..add(BranchEvent.getBranchInfo()),
          child: Container(),
        ),
        BlocProvider(create: (context) => _locale..loadInitialLocale()),
        BlocProvider(create: (context) => _notiCubit..loadNoti()),
        BlocProvider(create: (context) => _historyFilterCubit),
        BlocProvider(create: (context) => _requestFilterCubit),
        BlocProvider(
          create: (context) => _notiCountCubit..getUnreadCount(),
          child: Container(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) async {
              context.read<BranchBloc>().add(const BranchEvent.getBranchInfo());
            },
            orElse: () {},
          );
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          routerConfig: _appRouter.router,
        ),
      ),
    );
  }
}
