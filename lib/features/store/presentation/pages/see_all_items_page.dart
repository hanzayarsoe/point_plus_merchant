import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:merchant/features/store/domain/entities/item_entity.dart';
import 'package:merchant/features/store/presentation/bloc/item_bloc/item_bloc.dart';
import 'package:merchant/features/store/presentation/widgets/item_card.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SeeAllItemsPage extends StatefulWidget {
  const SeeAllItemsPage({super.key});

  @override
  State<SeeAllItemsPage> createState() => _SeeAllItemsPageState();
}

class _SeeAllItemsPageState extends State<SeeAllItemsPage> {
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final branch = authState.whenOrNull(authenticated: (branch) => branch);
    if (branch == null) {
      return Scaffold(body: Center(child: CupertinoActivityIndicator()));
    }
    return BlocProvider(
      create: (context) => ItemBloc(sl())
        ..add(
          ItemEvent.fetchPage(
            merchantId: branch.merchantId,
            allItems: true,
            promoItems: false,
          ),
        ),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Items', automaticallyImplyLeading: true),
        body: BlocBuilder<ItemBloc, PagingState<int, ItemEntity>>(
          builder: (context, state) {
            return PagedGridView(
              padding: AppSpacing.defaultPadding,
              state: state,
              fetchNextPage: () => context.read<ItemBloc>().add(
                ItemEvent.fetchPage(
                  merchantId: branch.merchantId,
                  allItems: true,
                  promoItems: false,
                ),
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                crossAxisSpacing: 50,
                childAspectRatio: 0.8,
              ),
              builderDelegate: PagedChildBuilderDelegate<ItemEntity>(
                itemBuilder: (context, item, index) {
                  return GestureDetector(
                    onTap: () =>
                        context.pushNamed(AppRoutes.itemDetails, extra: item),
                    child: ItemCard(item: item),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
