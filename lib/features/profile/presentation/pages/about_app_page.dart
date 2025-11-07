import 'package:flutter/material.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/profile/data/models/about_app_text.dart';
import 'package:merchant/features/profile/presentation/widgets/bullet_text.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About App', automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: AppSpacing.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('VERSION 1.0', style: Theme.of(context).textTheme.bodySmall),
            AppSpacing.extraLargeSizedBox,
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final para = aboutText[index];
                return BulletText(text: para);
              },
              separatorBuilder: (context, index) => AppSpacing.smallSizedBox,
              itemCount: aboutText.length,
            ),
            AppSpacing.extraLargeSizedBox,
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            AppSpacing.smallSizedBox,
            Text(
              "For questions about the Program or these Terms, please contact: Point Plus",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AppSpacing.extraSmallSizedBox,
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: 'Email: '),
                  TextSpan(
                    text: 'pointplus@gmail.com',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
