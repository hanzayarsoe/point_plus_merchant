import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
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
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}
