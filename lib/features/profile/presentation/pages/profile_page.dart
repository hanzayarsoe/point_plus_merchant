import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/profile/presentation/bloc/branch_bloc/branch_bloc.dart';
import 'package:merchant/features/profile/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:merchant/features/profile/presentation/cubits/noti_cubit/noti_cubit.dart';
import 'package:merchant/features/profile/presentation/widgets/custom_switch.dart';
import 'package:merchant/features/profile/presentation/widgets/logout_button.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_card.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_card_row.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_header.dart';
import 'package:merchant/shared/widgets/confirm_box.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ConfirmBox(
          dialogType: DialogType.delete,
          title: 'Logout',
          body: 'Are you sure to Logout ?',
          mainActionText: 'Logout',
          mainAction: () {
            dialogContext.pop();
            context.read<AuthBloc>().add(AuthEvent.logOut());
          },
          secondaryActionText: 'Cancel',
          secondaryAction: () => dialogContext.pop(),
        );
      },
    );
  }

  Future<void> _refreshData() async {
    context.read<AuthBloc>().add(const AuthEvent.refreshUser());
  }

  @override
  Widget build(BuildContext context) {
    final localeCode = context.watch<LocaleCubit>().state.locale.languageCode;
    return BlocConsumer<BranchBloc, BranchState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        updateBranchFailed: (failure) => true,
        updateBranchSuccessed: (updatedUser) => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          updateBranchFailed: (failure) =>
              showToast(message: failure.message, type: ToastType.error),
          updateBranchSuccessed: (updatedUser) => context.read<AuthBloc>().add(
            AuthEvent.updateBranchInfo(updatedUser),
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Profile', isTitleLarge: true),
          body: RefreshIndicator.adaptive(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.profileScreenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.largeSpacing,
                children: [
                  ProfileHeader(),
                  ProfileCard(
                    title: 'Account',
                    profileCardRows: [
                      ProfileCardRow(
                        icon: LucideIcons.userRound,
                        label: 'Personal Information',
                        onTap: () =>
                            context.pushNamed(AppRoutes.personalInformation),
                        bottomBorder: true,
                      ),
                      ProfileCardRow(
                        icon: LucideIcons.smartphone,
                        label: 'Change Mobile Number',
                        onTap: () =>
                            context.pushNamed(AppRoutes.changeMobileNumber),
                        bottomBorder: true,
                      ),
                      ProfileCardRow(
                        icon: LucideIcons.rectangleEllipsis,
                        label: 'Devices',
                        onTap: () => context.pushNamed(AppRoutes.devices),
                        bottomBorder: true,
                      ),
                      ProfileCardRow(
                        icon: LucideIcons.rectangleEllipsis,
                        label: 'Change Password',
                        onTap: () =>
                            context.pushNamed(AppRoutes.changePassword),
                      ),
                    ],
                  ),
                  ProfileCard(
                    title: 'App Settings',
                    profileCardRows: [
                      ProfileCardRow(
                        icon: LucideIcons.globe,
                        label: 'Language',
                        onTap: () =>
                            context.pushNamed(AppRoutes.changeLanguage),
                        rightText: localeCode == 'en' ? 'English' : 'မြန်မာ',
                      ),
                      BlocBuilder<NotiCubit, bool>(
                        builder: (context, isEnabled) {
                          return ProfileCardRow(
                            icon: LucideIcons.bell,
                            label: 'Notification',
                            onTap: () {},
                            customRightWidget: CustomSwitch(
                              value: isEnabled,
                              onChanged: (value) {
                                context.read<NotiCubit>().toggleNotifications(
                                  value,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  ProfileCard(
                    title: 'About',
                    profileCardRows: [
                      ProfileCardRow(
                        icon: LucideIcons.receiptText,
                        label: 'Privacy Policies',
                        onTap: () =>
                            context.pushNamed(AppRoutes.privacyPolicies),
                        bottomBorder: true,
                      ),
                      ProfileCardRow(
                        icon: LucideIcons.info,
                        label: 'About App',
                        onTap: () => context.pushNamed(AppRoutes.aboutApp),
                      ),
                    ],
                  ),
                  LogOutButton(onPressed: () => _logOut(context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
