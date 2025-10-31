import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppSpacing.defaultPadding,
        child: Column(children: [Text('History page')]),
      ),
    );
  }
}
