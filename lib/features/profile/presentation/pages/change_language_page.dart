import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/features/profile/presentation/cubits/locale_cubit/locale_cubit.dart';
import 'package:merchant/features/profile/presentation/widgets/language_tile.dart';
import 'package:merchant/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  @override
  Widget build(BuildContext context) {
    String selectedLanguage = context
        .watch<LocaleCubit>()
        .state
        .locale
        .languageCode;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Choose language',
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: AppSpacing.defaultPadding,
        child: Column(
          spacing: AppSpacing.largeSpacing,
          children: [
            // LanguageTile(
            //   isSelected: selectedLanguage == 'my',
            //   localeCode: 'my',
            //   onTap: () {
            //     setState(() {
            //       selectedLanguage = 'my';
            //     });
            //     context.read<LocaleCubit>().changeLocale(const Locale('my'));
            //   },
            // ),
            LanguageTile(
              isSelected: selectedLanguage == 'en',
              localeCode: 'en',
              onTap: () {
                setState(() {
                  selectedLanguage = 'en';
                });
                context.read<LocaleCubit>().changeLocale(const Locale('en'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
