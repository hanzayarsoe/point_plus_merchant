import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/auth/presentation/pages/forget_password_page.dart';
import 'package:merchant/features/auth/presentation/pages/login_page.dart';
import 'package:merchant/features/auth/presentation/pages/reset_password_page.dart';
import 'package:merchant/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:merchant/features/auth/presentation/pages/welcome_page.dart';
import 'package:merchant/features/home/domain/entities/point_transfer_entity.dart';
import 'package:merchant/features/home/presentation/bloc/point_transfer_bloc/point_transfer_bloc.dart';
import 'package:merchant/features/home/presentation/pages/history_page.dart';
import 'package:merchant/features/home/presentation/pages/home_page.dart';
import 'package:merchant/features/home/presentation/pages/point_transfer_page.dart';
import 'package:merchant/features/home/presentation/pages/profile_page.dart';
import 'package:merchant/features/home/presentation/pages/scanner_page.dart';
import 'package:merchant/features/home/presentation/pages/search_with_account_number_page.dart';
import 'package:merchant/features/home/presentation/pages/store_page.dart';
import 'package:merchant/shared/widgets/bottom_navigation_bar.dart';

class AppRouter {
  final AuthBloc authBloc;
  late GoRouter router;
  AppRouter(this.authBloc) {
    router = GoRouter(
      navigatorKey: sl<GlobalKey<NavigatorState>>(),
      initialLocation: '/',
      debugLogDiagnostics: false,
      redirect: (context, state) {
        final authState = authBloc.state;
        final location = state.matchedLocation;

        final publicRoutes = [
          '/',
          '/login',
          '/forget-password',
          '/verify-otp',
          '/reset-password',
        ];

        final isLoadingOrInitial = authState.maybeWhen(
          initial: () => true,
          loading: () => true,
          orElse: () => false,
        );

        final isAuthenticated = authState.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );

        final isUnAuthenticated = authState.maybeWhen(
          unauthenticated: () => true,
          orElse: () => false,
        );

        if (isLoadingOrInitial) {
          return null;
        }

        final isPublicRoute = publicRoutes.contains(location);

        if (isAuthenticated && isPublicRoute) {
          log('Redirecting authenticated user from $location to /home');
          return '/home';
        }

        if (isUnAuthenticated && !isPublicRoute) {
          log('Redirecting unauthenticated user from $location to /');
          return '/';
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream([authBloc.stream]),
      routes: [
        GoRoute(
          name: AppRoutes.initial,
          path: '/',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: WelcomePage()),
        ),
        GoRoute(
          name: AppRoutes.logIn,
          path: '/login',
          pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
        ),
        GoRoute(
          name: AppRoutes.forgetPassword,
          path: '/forget-password',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ForgetPasswordPage()),
        ),
        GoRoute(
          name: AppRoutes.verifyNumber,
          path: '/verify-otp',
          pageBuilder: (context, state) {
            final String phoneNumber = state.extra as String;
            return NoTransitionPage(
              child: VerifyOtpPage(phoneNumber: phoneNumber),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.resetPassword,
          path: '/reset-password',
          pageBuilder: (context, state) {
            final String phoneNumber = state.extra as String;
            return NoTransitionPage(
              child: ResetPasswordPage(phoneNumber: phoneNumber),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.scanner,
          path: '/scanner',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ScannerPage()),
        ),
        GoRoute(
          name: AppRoutes.searchAccount,
          path: '/search-account',
          pageBuilder: (context, state) {
            final String index = state.extra as String;
            final int initialIndex = int.tryParse(index) ?? 1;
            return NoTransitionPage(
              child: SearchWithAccountNumberPage(initialInde: initialIndex),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.pointTransfer,
          path: '/point-transfer',
          pageBuilder: (context, state) {
            final transferType = state.extra as PointTransferEntity;
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => PointTransferBloc(sl()),
                child: PointTransferPage(pointTransferEntity: transferType),
              ),
            );
          },
        ),
        StatefulShellRoute(
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.home,
                  path: '/home',
                  pageBuilder: (context, state) =>
                      NoTransitionPage(child: HomePage()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.history,
                  path: '/history',
                  pageBuilder: (context, state) =>
                      NoTransitionPage(child: HistoryPage()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.store,
                  path: '/store',
                  pageBuilder: (context, state) =>
                      NoTransitionPage(child: StorePage()),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.profile,
                  path: '/profile',
                  pageBuilder: (context, state) =>
                      NoTransitionPage(child: ProfilePage()),
                ),
              ],
            ),
          ],
          navigatorContainerBuilder: (context, navigationShell, children) {
            return children[navigationShell.currentIndex];
          },
          builder: (context, state, navigationShell) {
            return Scaffold(
              body: navigationShell,
              bottomNavigationBar: CustomBottomNavigationBar(
                navigationShell: navigationShell,
              ),
            );
          },
        ),
      ],
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(List<Stream<dynamic>> streams) {
    notifyListener = () => notifyListeners();

    _subscriptions = streams.map((stream) {
      return stream.asBroadcastStream().listen((_) => notifyListener());
    }).toList();
  }

  late final VoidCallback notifyListener;
  late final List<StreamSubscription<dynamic>> _subscriptions;

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
