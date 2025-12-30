import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/shared/widgets/custom_cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final user = authState.whenOrNull(authenticated: (user) => user);
    final isLoading = authState.maybeWhen(
      orElse: () => false,
      loading: () => true,
    );
    return Container(
      padding: AppSpacing.profileHeaderCardPadding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: AppSpacing.normalBorderRadiusCircular,
      ),
      child: Row(
        spacing: AppSpacing.defaultSpacing,
        children: [
          ClipOval(
            child: CustomCachedNetworkImage(
              profileUrl: user?.profileUrl,
              width: 80,
              height: 80,
              isProfile: true,
            ),
          ),
          Expanded(
            child: Skeletonizer(
              enabled: isLoading || user == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: AppSpacing.extraSmallPadding,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topCenter,
                        end: AlignmentGeometry.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(
                            context,
                          ).extension<AppColors>()!.buttonGradient!,
                        ],
                      ),
                      borderRadius: AppSpacing.smallCircularBorderRadius,
                    ),
                    child: Text(
                      'Store Manager',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
