import 'package:flutter/material.dart';
import 'package:merchant/features/store/presentation/widgets/see_all.dart';

class HomeTitleBar extends StatelessWidget {
  final String title;
  final VoidCallback seeAll;
  const HomeTitleBar({super.key, required this.title, required this.seeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SeeAll(onPressed: seeAll),
      ],
    );
  }
}
