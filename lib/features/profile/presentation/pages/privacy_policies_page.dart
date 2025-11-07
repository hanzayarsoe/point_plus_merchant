import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:merchant/shared/widgets/paragraph_widget.dart';
import 'package:merchant/features/profile/data/models/terms_and_conditon_text.dart';

class PrivacyPoliciesPage extends StatefulWidget {
  const PrivacyPoliciesPage({super.key});

  @override
  State<PrivacyPoliciesPage> createState() => _PrivacyPoliciesPageState();
}

class _PrivacyPoliciesPageState extends State<PrivacyPoliciesPage> {
  final List<MapEntry<String, List<String>>> policies = termsAndConditons
      .entries
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy Policies',
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final para = policies[index];
                return ParagraphWidget(title: para.key, content: para.value);
              },
              separatorBuilder: (context, index) =>
                  AppSpacing.extraLargeSizedBox,
              itemCount: termsAndConditons.length,
            ),
          ],
        ),
      ),
    );
  }
}
