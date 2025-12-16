import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/helper_function.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/noti_count_cubit/noti_count_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';

class HomeProfileCard extends StatelessWidget {
  const HomeProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final authSate = context.watch<AuthBloc>().state;
    final user = authSate.whenOrNull(authenticated: (user) => user);
    final notiCountState = context.watch<NotiCountCubit>().state;
    final int unreadCount = notiCountState.maybeWhen(
      orElse: () => 0,
      loaded: (count) => count,
    );
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

        Badge.count(
          count: unreadCount,
          isLabelVisible: unreadCount > 0,
          backgroundColor: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.onSurface,
          textStyle: Theme.of(context).textTheme.labelSmall,
          alignment: AlignmentGeometry.xy(0.6, -1),
          child: CustomIcon(
            onPressed: () => context.pushNamed(AppRoutes.noti),
            icon: Icon(
              LucideIcons.bell,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            padding: EdgeInsets.all(10.0),
            paddingColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
        ),
      ],
    );
  }
}
