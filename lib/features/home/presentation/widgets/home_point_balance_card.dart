import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/utils/formatter.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';

class HomePointBalanceCard extends StatefulWidget {
  const HomePointBalanceCard({super.key});

  @override
  State<HomePointBalanceCard> createState() => _HomePointBalanceCardState();
}

class _HomePointBalanceCardState extends State<HomePointBalanceCard> {
  var _isObsurce = false;
  @override
  Widget build(BuildContext context) {
    final userState = context.watch<AuthBloc>().state;
    final user = userState.whenOrNull(authenticated: (user) => user);
    return Container(
      padding: AppSpacing.defaultPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
        borderRadius: AppSpacing.normalBorderRadiusCircular,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: AppSpacing.extraSmallSpacing,
            children: [
              SvgPicture.asset(
                AppAssets.starIcon,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              Text(
                'Points Balance',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
          AppSpacing.smallSizedBox,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_isObsurce ? Formatter.fromNumberAsHidden(user?.branchAmount ?? 0) : Formatter.formatNumber(user?.branchAmount ?? 0)} Pts',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: AppSpacing.smallSpacing),
              InkWell(
                onTap: () => setState(() {
                  _isObsurce = !_isObsurce;
                }),
                child: Icon(
                  _isObsurce ? LucideIcons.eyeClosed : LucideIcons.eye,
                  size: 30,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
          AppSpacing.largeSizedBox,
          Text(
            '${user?.manager.name}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.surface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppSpacing.smallSizedBox,
          Text(
            Formatter.formatAsCardNumber(user?.accountNumber ?? ''),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
