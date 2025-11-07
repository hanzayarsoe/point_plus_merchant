import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();
  static const EdgeInsets defaultPadding = EdgeInsets.all(20);
  static const EdgeInsets defaultPaddingWithoutTop = EdgeInsets.only(
    left: 20,
    right: 20,
    bottom: 20,
  );
  static const EdgeInsets normalPadding = EdgeInsets.all(16);
  static const EdgeInsets bottomButtonPadding = EdgeInsets.only(
    left: 20,
    right: 20,
    bottom: 70,
  );
  static const EdgeInsets smallPadding = EdgeInsets.all(10.0);
  static const EdgeInsets extraSmallPadding = EdgeInsets.all(4.0);
  static const double defaultSpacing = 12.0;
  static const double paragraphSpacing = 28.0;
  static const double megaLargeSpacing = 38.0;
  static const double extraLargeSpacing = 24.0;
  static const double largeSpacing = 20.0;
  static const double mediumSpacing = 16.0;
  static const double smallSpacing = 10.0;
  static const double mediumSmallSpacing = 8.0;
  static const double extraSmallSpacing = 4.0;
  static const SizedBox megaLargeSizedBox = SizedBox(height: 32.0);
  static const SizedBox extraLargeSizedBox = SizedBox(height: 24.0);
  static const SizedBox largeSizedBox = SizedBox(height: 20.0);
  static const SizedBox mediumSizedBox = SizedBox(height: 16.0);
  static const SizedBox smallSizedBox = SizedBox(height: 10.0);
  static const SizedBox extraSmallSizedBox = SizedBox(height: 4.0);
  static const double defaultMergin = 10.0;
  static const double inkWellButtonRadius = 20.0;
  static const double seeAllIconSize = 16.0;
  static const double iconSize = 20.0;
  static const double imageSize = 10.0;
  static const double logoSize = 10.0;
  static const double profileImageSize = 10.0;

  // Home Screen Spacing
  static const EdgeInsets gradientButtonPadding = EdgeInsets.symmetric(
    vertical: 12.0,
  );

  static const EdgeInsets noInernetSanckBarPadding = EdgeInsets.all(8.0);

  static const EdgeInsets homeCardPadding = EdgeInsets.only(
    left: 4,
    top: 6,
    right: 4,
    bottom: 20,
  );
  static const EdgeInsets homeGradientCardPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 24,
  );
  static const EdgeInsets recentMerchantCardImagePadding = EdgeInsets.only(
    top: 22,
    left: 26,
    right: 26,
  );

  static const EdgeInsets merchantCategoriesPadding = EdgeInsets.symmetric(
    horizontal: 20,
  );

  static const EdgeInsets merchantCardPadding = EdgeInsets.symmetric(
    horizontal: 4.0,
    vertical: 12.0,
  );

  static const EdgeInsets branchCardPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16,
  );

  static BorderRadius smallCircularBorderRadius = BorderRadius.circular(10);

  static BorderRadius extraSmallCircularBorderRadius = BorderRadius.circular(5);

  static const EdgeInsets customTabBarPadding = EdgeInsets.only(
    left: 20,
    right: 20,
  );

  static const EdgeInsets customTabBarMargin = EdgeInsets.only(top: 35);

  static const EdgeInsets transitionTilePadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  );

  // Profile Screen Spacing
  static const EdgeInsets profileScreenPadding = EdgeInsets.only(
    top: 16.0,
    right: 20.0,
    left: 20.0,
    bottom: 20.0,
  );

  static const EdgeInsets profileHeaderCardPadding = EdgeInsets.all(16.0);

  static BorderRadius normalBorderRadiusCircular = BorderRadius.circular(20.0);

  static BorderRadius bigBorderRadiusCircular = BorderRadius.circular(40.0);

  static const EdgeInsets profileCardPadding = EdgeInsets.only(
    left: 20.0,
    top: 16.0,
    right: 20.0,
    bottom: 8.0,
  );

  static const EdgeInsets profileCardRowPadding = EdgeInsets.symmetric(
    vertical: 16.0,
  );

  static const EdgeInsets bottomActionButtonPadding = EdgeInsets.only(
    left: 20,
    right: 20,
    bottom: 20,
  );

  static const EdgeInsets languageCardPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 16,
  );
}
