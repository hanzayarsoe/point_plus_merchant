import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const CustomBottomNavigationBar({super.key, required this.navigationShell});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.navigationShell.currentIndex,
      onTap: (value) => widget.navigationShell.goBranch(value),
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Icon(LucideIcons.house),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Icon(LucideIcons.history),
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Icon(LucideIcons.store),
          ),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Icon(LucideIcons.user),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
