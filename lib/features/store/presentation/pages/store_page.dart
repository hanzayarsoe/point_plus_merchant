import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/core/themes/extensions/app_colors.dart';
import 'package:merchant/features/auth/domain/entities/branch.dart';
import 'package:merchant/features/home/presentation/widgets/custom_icon.dart';
import 'package:merchant/features/profile/presentation/bloc/branch_bloc/branch_bloc.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:merchant/features/store/presentation/widgets/about_us.dart';
import 'package:merchant/features/store/presentation/widgets/horizontal_list_view.dart';
import 'package:merchant/features/store/presentation/widgets/item_card.dart';
import 'package:merchant/features/store/presentation/widgets/store_detail.dart';
import 'package:merchant/features/store/presentation/widgets/store_header.dart';
import 'package:merchant/shared/widgets/loading_overlay.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final double topImageSize = 240;
  final double overlap = 100;

  Future<void> _refreshData() async {
    final branchState = context.read<BranchBloc>().state;
    final Branch? branch = branchState.whenOrNull(
      loadedBranch: (branch) => branch,
    );
    if (branch != null) {
      context.read<StoreBloc>().add(
        StoreEvent.fetchStoreData(merchantId: branch.merchantId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final branchState = context.watch<BranchBloc>().state;
    return branchState.maybeWhen(
      loadedBranch: (branch) => _buildLoadedState(context, branch),
      failedToLoadBranch: (failure) => _buildErrorState(context),
      orElse: () =>
          const Scaffold(body: Center(child: CupertinoActivityIndicator())),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to load store data'),
            AppSpacing.mediumSizedBox,
            ElevatedButton(
              onPressed: () => context.read<BranchBloc>().add(
                const BranchEvent.getBranchInfo(),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, Branch branch) {
    return BlocProvider(
      create: (context) =>
          StoreBloc(sl())
            ..add(StoreEvent.fetchStoreData(merchantId: branch.merchantId)),
      child: Scaffold(
        extendBody: true,
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  AppAssets.mapImage,
                  width: double.infinity,
                  height: topImageSize,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsets.only(top: topImageSize - overlap),
                  padding: AppSpacing.defaultPadding,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSpacing.largeSpacing),
                      topRight: Radius.circular(AppSpacing.largeSpacing),
                    ),
                  ),
                  child: BlocBuilder<StoreBloc, StoreState>(
                    builder: (context, state) {
                      final (promoItems, allItems) = state.maybeWhen(
                        orElse: () => (const <ItemEntity>[], <ItemEntity>[]),
                        loadedStoreData: (promoItems, allItems) =>
                            (promoItems, allItems),
                      );
                      final isLoading = state.maybeWhen(
                        orElse: () => false,
                        loading: () => true,
                      );
                      return LoadingOverlay(
                        isLoading: isLoading,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StoreHeader(
                                storeName: branch.name,
                                profileUrl: branch.profileUrl,
                                rating: 1,
                              ),
                              AppSpacing.megaLargeSizedBox,
                              StoreDetail(
                                address: branch.branchAddress,
                                primaryPhoneNumber: branch.primaryPhoneNumber,
                                secondaryPhoneNumber:
                                    branch.secondaryPhoneNumber,
                                openTime: branch.openTime,
                                closeTime: branch.closeTime,
                              ),
                              AppSpacing.megaLargeSizedBox,
                              AboutUs(aboutText: branch.about),
                              AppSpacing.megaLargeSizedBox,
                              if (promoItems.isNotEmpty) ...[
                                HorizontalListview(
                                  widgetTitle: 'Promotions',
                                  seeAllAction: () =>
                                      context.pushNamed(AppRoutes.seeAllPromos),
                                  gap: AppSpacing.largeSpacing,
                                  widgets: promoItems
                                      .map((promo) => ItemCard(item: promo))
                                      .toList(),
                                ),
                                AppSpacing.megaLargeSizedBox,
                              ],
                              if (allItems.isNotEmpty) ...[
                                HorizontalListview(
                                  widgetTitle: 'Items',
                                  seeAllAction: () =>
                                      context.pushNamed(AppRoutes.seeAllItems),
                                  gap: AppSpacing.largeSpacing,
                                  widgets: allItems
                                      .map((item) => ItemCard(item: item))
                                      .toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: CustomIcon(
                    onPressed: () =>
                        context.pushNamed(AppRoutes.editStoreProfile),
                    icon: Icon(LucideIcons.squarePen, size: 24),
                    padding: AppSpacing.normalPadding,
                    paddingColor: Theme.of(
                      context,
                    ).extension<AppColors>()!.actionBlueColor!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
