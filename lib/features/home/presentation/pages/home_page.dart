import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/features/home/presentation/widgets/home_head_line_text.dart';
import 'package:merchant/features/home/presentation/widgets/home_point_balance_card.dart';
import 'package:merchant/features/home/presentation/widgets/home_profile_card.dart';
import 'package:merchant/features/home/presentation/widgets/quick_actions.dart';
import 'package:go_router/go_router.dart';

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
      (title: 'Your Request', icon: LucideIcons.history, onPressed: () {}),
      (title: 'Withdraw', icon: LucideIcons.squareStar, onPressed: () {}),
      (title: 'Recharge', icon: LucideIcons.walletMinimal, onPressed: () {}),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return null;

                        // final recent =
                        // return
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
