import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/constants/enum.dart';
import 'package:merchant/core/injection/injection_container.dart';
import 'package:merchant/features/history/presentation/bloc/history_bloc/history_bloc.dart';
import 'package:merchant/features/history/presentation/cubit/cubit/history_filter_cubit.dart';
import 'package:merchant/features/history/presentation/widgets/custom_bottom_sheet.dart';
import 'package:merchant/features/history/presentation/widgets/history_group_list.dart';
import 'package:merchant/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HistoryFilterCubit _historyFilterCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HistoryTransactionType.values.take(5).length,
      vsync: this,
    );
    _tabController.addListener(_onTabChanged);
    _historyFilterCubit = context.read<HistoryFilterCubit>();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _historyFilterCubit.clearFilters();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      final selectedType = HistoryTransactionType.values[_tabController.index];
      _historyFilterCubit.updateFilters(type: selectedType);
    }
  }

  Future<void> _filterDate() async {
    final currentFilters = _historyFilterCubit.state;
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
          isHistoryFilter: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'History',
        isTitleLarge: true,
        bottom: CustomTabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          dividerColor: Theme.of(context).colorScheme.onSurface,
          dividerHeight: 0.5,
          tabController: _tabController,
          padding: EdgeInsets.only(top: AppSpacing.defaultSpacing),
          tabs: [
            ...HistoryTransactionType.values
                .take(5)
                .map((tab) => Text(tab.displayName)),
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
        children: HistoryTransactionType.values.take(5).map((type) {
          return BlocProvider(
            create: (context) => HistoryBloc(sl()),
            child: HistoryGroupList(historyType: type),
          );
        }).toList(),
      ),
    );
  }
}
