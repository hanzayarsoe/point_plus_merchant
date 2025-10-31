import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppSpacing.defaultPadding,
        child: Column(children: [Text('Store page')]),
      ),
    );
  }
}
