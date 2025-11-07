import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_card.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_card_row.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Devices', automaticallyImplyLeading: true),
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View your devices',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSpacing.smallSizedBox,
            Text(
              'Check your devices that are used to log in!',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
            AppSpacing.largeSizedBox,
            ProfileCard(
              profileCardRows: [
                ProfileCardRow(
                  icon: LucideIcons.smartphone,
                  label: 'iPhone 16 pro',
                  onTap: () {},
                  customRightWidget: null,
                  bottomBorder: true,
                ),
                ProfileCardRow(
                  icon: LucideIcons.monitor,
                  label: 'iPhone 16 pro',
                  onTap: () {},
                  customRightWidget: null,
                  bottomBorder: true,
                ),
                ProfileCardRow(
                  icon: LucideIcons.smartphone,
                  label: 'iPhone 16 pro',
                  onTap: () {},
                  customRightWidget: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
