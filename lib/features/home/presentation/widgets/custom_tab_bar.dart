import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    this.tabController,
    required this.tabs,
    this.onTap,
    this.tabAlignment,
    this.isScrollable,
    this.padding,
    this.margin,
  });

  final TabController? tabController;
  final List<Widget> tabs;
  final Function(int)? onTap;
  final TabAlignment? tabAlignment;
  final bool? isScrollable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Size get preferredSize {
    final double verticalMergin = margin?.vertical ?? 0.0;
    return Size.fromHeight(35.0 + verticalMergin);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TabBar(
        tabAlignment: tabAlignment,
        controller: tabController,
        isScrollable: isScrollable ?? true,
        padding: padding,
        indicatorWeight: 2.0,
        tabs: tabs,
        onTap: onTap,
      ),
    );
  }
}
