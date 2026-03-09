import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/noti_count_cubit/noti_count_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/home_head_line_text.dart';
import 'package:merchant/features/home/presentation/widgets/home_point_balance_card.dart';
import 'package:merchant/features/home/presentation/widgets/home_profile_card.dart';
import 'package:merchant/features/home/presentation/widgets/quick_actions.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/features/home/presentation/widgets/recent_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _refreshData(BuildContext context) async {
    context.read<AuthBloc>().add(const AuthEvent.refreshUser());
    context.read<NotiCountCubit>().getUnreadCount();
    context.read<HistoryBloc>().add(const HistoryEvent.reset());
    context.read<HistoryBloc>().add(
      const HistoryEvent.getHistories(
        type: null,
        startDate: null,
        endDate: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<({String title, IconData icon, VoidCallback onPressed})>
    quickActions = [
      (
        title: 'Scanner',
        icon: LucideIcons.scan,
        onPressed: () => context.pushNamed(AppRoutes.scanner),
      ),
      (
        title: 'Your Request',
        icon: LucideIcons.history,
        onPressed: () => context.pushNamed(AppRoutes.request),
      ),
      (
        title: 'Withdraw',
        icon: LucideIcons.squareStar,
        onPressed: () => context.pushNamed(AppRoutes.withdraw),
      ),
      (
        title: 'Recharge',
        icon: LucideIcons.walletMinimal,
        onPressed: () => context.pushNamed(AppRoutes.recharge),
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => HistoryBloc(sl())
            ..add(
              const HistoryEvent.getHistories(
                type: null,
                startDate: null,
                endDate: null,
              ),
            ),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                authenticated: (_) {
                  context.read<HistoryBloc>().add(const HistoryEvent.reset());
                  context.read<HistoryBloc>().add(
                    const HistoryEvent.getHistories(
                      type: null,
                      startDate: null,
                      endDate: null,
                    ),
                  );
                },
              );
            },
            child: Builder(
              builder: (context) {
                return RefreshIndicator(
                  onRefresh: () => _refreshData(context),
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: AppSpacing.defaultPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeProfileCard(),
                              AppSpacing.extraLargeSizedBox,
                              HomePointBalanceCard(),
                              AppSpacing.largeSizedBox,
                              HomeHeadLineText(title: 'Quick Actions'),
                              AppSpacing.largeSizedBox,
                              QuickActions(quickActions: quickActions),
                              AppSpacing.largeSizedBox,
                              HomeHeadLineText(title: 'Recent'),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: AppSpacing.defaultPadding,
                        sliver: RecentTransactions(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
