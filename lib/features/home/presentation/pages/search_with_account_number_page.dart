import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/features/home/presentation/cubits/search_customer_cubit/search_customer_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:merchant/features/home/presentation/widgets/search_account.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class SearchWithAccountNumberPage extends StatefulWidget {
  final int initialInde;
  const SearchWithAccountNumberPage({super.key, required this.initialInde});

  @override
  State<SearchWithAccountNumberPage> createState() =>
      _SearchWithAccountNumberPageState();
}

class _SearchWithAccountNumberPageState
    extends State<SearchWithAccountNumberPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final SearchCustomerCubit _searchCustomerCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialInde,
    );
    _searchCustomerCubit = SearchCustomerCubit(sl());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCustomerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchCustomerCubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Search with Account Number',
          automaticallyImplyLeading: true,
          bottom: CustomTabBar(
            margin: AppSpacing.customTabBarMargin,
            padding: AppSpacing.customTabBarPadding,
            tabController: _tabController,
            tabAlignment: TabAlignment.fill,
            isScrollable: false,
            tabs: [Text('Transfer Points'), Text('Receive Points')],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SearchAccount(type: 'request'),
            SearchAccount(type: 'redeem'),
          ],
        ),
      ),
    );
  }
}
