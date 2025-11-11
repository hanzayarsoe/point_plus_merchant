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
import 'package:merchant/features/home/presentation/pages/scanner_page.dart';
import 'package:merchant/features/home/presentation/pages/search_with_account_number_page.dart';
import 'package:merchant/features/profile/presentation/pages/about_app_page.dart';
import 'package:merchant/features/profile/presentation/pages/change_language_page.dart';
import 'package:merchant/features/profile/presentation/pages/change_mobile_number_page.dart';
import 'package:merchant/features/profile/presentation/pages/change_mobile_number_verify_otp_page.dart';
import 'package:merchant/features/profile/presentation/pages/change_password_page.dart';
import 'package:merchant/features/profile/presentation/pages/devices_page.dart';
import 'package:merchant/features/profile/presentation/pages/personal_information_page.dart';
import 'package:merchant/features/profile/presentation/pages/privacy_policies_page.dart';
import 'package:merchant/features/profile/presentation/pages/profile_page.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/presentation/pages/edit_store_profile_page.dart';
import 'package:merchant/features/store/presentation/pages/item_details_page.dart';
import 'package:merchant/features/store/presentation/pages/see_all_items_page.dart';
import 'package:merchant/features/store/presentation/pages/see_all_promo_page.dart';
import 'package:merchant/features/store/presentation/pages/store_page.dart';
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
          '/verify-otp',
          '/forget-password',
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
            final phoneNumber = state.extra as String;
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
        GoRoute(
          name: AppRoutes.changeMobileNumberVerifyOtp,
          path: '/change-mobile-number-verify-otp',
          pageBuilder: (context, state) {
            final phoneNumber = state.extra as String;
            return NoTransitionPage(
              child: ChangeMobileNumberVerifyOtpPage(phoneNumber: phoneNumber),
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
                  routes: [
                    GoRoute(
                      name: AppRoutes.editStoreProfile,
                      path: 'edit-store-profile',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: EditStoreProfilePage()),
                    ),
                    GoRoute(
                      name: AppRoutes.seeAllPromos,
                      path: 'see-all-promos',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: SeeAllPromoPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.seeAllItems,
                      path: 'see-all-items',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: SeeAllItemsPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.itemDetails,
                      path: 'item-details',
                      pageBuilder: (context, state) {
                        final item = state.extra as ItemEntity;
                        return NoTransitionPage(
                          child: ItemDetailsPage(item: item),
                        );
                      },
                    ),
                  ],
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
                  routes: [
                    GoRoute(
                      name: AppRoutes.personalInformation,
                      path: 'personal-information,',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: PersonalInformationPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.changeMobileNumber,
                      path: 'change-mobile-number',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: ChangeMobileNumberPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.devices,
                      path: 'devices',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: DevicesPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.changePassword,
                      path: 'change-password',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: ChangePasswordPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.changeLanguage,
                      path: 'change-language',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: ChangeLanguagePage()),
                    ),
                    GoRoute(
                      name: AppRoutes.privacyPolicies,
                      path: 'privacy-policies',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: PrivacyPoliciesPage()),
                    ),
                    GoRoute(
                      name: AppRoutes.aboutApp,
                      path: 'about-app',
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: AboutAppPage()),
                    ),
                  ],
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
