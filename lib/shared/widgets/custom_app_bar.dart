import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  final String? title;
  final Color? titleColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.automaticallyImplyLeading,
    this.titleColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (automaticallyImplyLeading != null &&
                    automaticallyImplyLeading!)
                  IconButton(
                    icon: Icon(
                      LucideIcons.chevronLeft,
                      size: 24,
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () => Navigator.of(context).canPop()
                        ? Navigator.of(context).pop()
                        : () {},
                  ),
                if (title != null)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: AppSpacing.extraSmallSpacing,
                        left: AppSpacing.extraSmallSpacing,
                      ),
                      child: Text(
                        title!,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: titleColor),
                      ),
                    ),
                  ),

                if (actions != null) ...actions!,
              ],
            ),
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    final totalHeight = kToolbarHeight + (bottom?.preferredSize.height ?? 0);
    return Size.fromHeight(totalHeight);
  }
}
