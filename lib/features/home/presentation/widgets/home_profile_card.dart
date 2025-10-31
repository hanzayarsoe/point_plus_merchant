import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/utils/helper_function.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';

class HomeProfileCard extends StatelessWidget {
  const HomeProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<AuthBloc>().state;
    final user = userState.whenOrNull(authenticated: (user) => user);
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            AppAssets.userImage,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: AppSpacing.smallSpacing),
        Expanded(
          child: Text(
            '${HelperFunction.getGreeting()}, \n${user?.manager.name}',
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CustomIcon(
          icon: Icon(
            LucideIcons.history,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          padding: EdgeInsets.all(10.0),
          paddingColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
      ],
    );
  }
}
