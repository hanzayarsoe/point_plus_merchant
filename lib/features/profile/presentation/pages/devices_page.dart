import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/features/profile/presentation/bloc/device_bloc/devices_bloc.dart';
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
    return BlocProvider(
      create: (context) =>
          sl<DevicesBloc>()..add(const DevicesEvent.fetchDevices()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Devices',
          automaticallyImplyLeading: true,
        ),
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
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSpacing.largeSizedBox,
              Expanded(
                child: BlocBuilder<DevicesBloc, DevicesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () =>
                          const Center(child: CupertinoActivityIndicator()),
                      failed: (failure) => Center(child: Text(failure.message)),
                      loaded: (devices) {
                        if (devices.isEmpty) {
                          return const Center(child: Text('No devices found'));
                        }
                        return SingleChildScrollView(
                          child: ProfileCard(
                            profileCardRows: devices.asMap().entries.map((
                              entry,
                            ) {
                              final index = entry.key;
                              final device = entry.value;
                              final isLast = index == devices.length - 1;

                              return ProfileCardRow(
                                icon: device.deviceType.toUpperCase() == 'WEB'
                                    ? LucideIcons.monitor
                                    : LucideIcons.smartphone,
                                label: device.deviceName,
                                onTap: () {},
                                customRightWidget: device.currentSession
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withAlpha(51),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          'Current',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(color: Colors.green),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                bottomBorder: !isLast,
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
