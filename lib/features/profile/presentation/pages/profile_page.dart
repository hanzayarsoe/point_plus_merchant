import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/utils/toast.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:merchant/features/profile/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:merchant/features/profile/presentation/cubits/noti_cubit/noti_cubit.dart';
import 'package:merchant/features/profile/presentation/widgets/custom_switch.dart';
import 'package:merchant/features/profile/presentation/widgets/logout_button.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_card.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_card_row.dart';
import 'package:merchant/features/profile/presentation/widgets/profile_header.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:toastification/toastification.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _logOut() {
    context.read<AuthBloc>().add(AuthEvent.logOut());
  }

  @override
  Widget build(BuildContext context) {
    final localeCode = context.watch<LocaleCubit>().state.locale.languageCode;
    final isNotiEnabled = context.watch<NotiCubit>().state;
    return BlocConsumer<UserBloc, UserState>(
      listenWhen: (previous, current) => current.maybeWhen(
        orElse: () => false,
        updateUserFailed: (failure) => true,
        updateUserSuccessed: (updatedUser) => true,
      ),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          updateUserFailed: (failure) => showToast(
            message: failure.message,
            type: ToastificationType.error,
          ),
          updateUserSuccessed: (updatedUser) => context.read<AuthBloc>().add(
            AuthEvent.updateUserData(updatedUser),
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Profile', isTitleLarge: true),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                      onTap: () => context.pushNamed(AppRoutes.changePassword),
                    ),
                  ],
                ),
                ProfileCard(
                  title: 'App Settings',
                  profileCardRows: [
                    ProfileCardRow(
                      icon: LucideIcons.globe,
                      label: 'Language',
                      onTap: () => context.pushNamed(AppRoutes.changeLanguage),
                      rightText: localeCode == 'en' ? 'English' : 'မြန်မာ',
                    ),
                    BlocBuilder<NotiCubit, bool>(
                      builder: (context, isEnabled) {
                        return ProfileCardRow(
                          icon: LucideIcons.bell,
                          label: 'Notification',
                          onTap: () {
                            context.read<NotiCubit>().setNoti(!isNotiEnabled);
                          },
                          customRightWidget: CustomSwitch(
                            value: isEnabled,
                            onChanged: (value) {
                              context.read<NotiCubit>().setNoti(value);
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
                      onTap: () => context.pushNamed(AppRoutes.privacyPolicies),
                      bottomBorder: true,
                    ),
                    ProfileCardRow(
                      icon: LucideIcons.info,
                      label: 'About App',
                      onTap: () => context.pushNamed(AppRoutes.aboutApp),
                    ),
                  ],
                ),
                LogOutButton(onPressed: () => _logOut()),
              ],
            ),
          ),
        );
      },
    );
  }
}
