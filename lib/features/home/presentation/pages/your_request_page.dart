import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/features/history/presentation/widgets/custom_bottom_sheet.dart';
import 'package:merchant/features/home/presentation/bloc/request_history_bloc/request_history_bloc.dart';
import 'package:merchant/features/home/presentation/cubits/request_filter_cubit/cubit/request_filter_cubit.dart';
import 'package:merchant/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:merchant/features/home/presentation/widgets/request_transaction.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class YourRequestPag extends StatefulWidget {
  const YourRequestPag({super.key});

  @override
  State<YourRequestPag> createState() => _YourRequestPageState();
}

class _YourRequestPageState extends State<YourRequestPag>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RequestFilterCubit _requestFilterCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: RequestTransactionType.values.length,
      vsync: this,
    );
    _tabController.addListener(_onTabChanged);
    _requestFilterCubit = context.read<RequestFilterCubit>();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _requestFilterCubit.clearFilters();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final selectedType = RequestTransactionType.values[_tabController.index];
      _requestFilterCubit.updateFilters(type: selectedType);
    }
  }

  Future<void> _filterDate() async {
    final currentFilters = _requestFilterCubit.state;
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(
          top: Radius.circular(AppSpacing.largeSpacing),
        ),
      ),
      builder: (BuildContext context) {
        return CustomBottomSheet(
          initialChipIndex: currentFilters.selectedChipIndex,
          startDate: currentFilters.startDate,
          endDate: currentFilters.endDate,
          isHistoryFilter: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestHistoryBloc(sl()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Your Request',
          isTitleLarge: true,
          automaticallyImplyLeading: true,
          bottom: CustomTabBar(
            tabAlignment: TabAlignment.start,
            dividerColor: Theme.of(context).colorScheme.onSurface,
            dividerHeight: 0.5,
            tabController: _tabController,
            padding: EdgeInsets.only(
              top: AppSpacing.defaultSpacing,
              left: AppSpacing.defaultSpacing,
            ),
            tabs: [
              ...RequestTransactionType.values.map(
                (tab) => Text(tab.displayName),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => _filterDate(),
              child: Icon(LucideIcons.funnel, size: 20),
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: RequestTransactionType.values.map((_) {
            return RequestTransaction();
          }).toList(),
        ),
      ),
    );
  }
}
