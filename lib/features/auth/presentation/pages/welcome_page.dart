import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merchant/core/constants/app_assets.dart';
import 'package:merchant/core/constants/app_spacing.dart';
import 'package:merchant/core/router/app_routes.dart';
import 'package:merchant/features/auth/presentation/pages/splash_page.dart';
import 'package:merchant/features/auth/presentation/widgets/carousel_widget.dart';
import 'package:merchant/features/auth/presentation/widgets/gradient_elevated_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _timer;
  bool _showSplash = true;
  final List<({String image, String title, String body})> _carouselItems = [
    (
      image: AppAssets.appLogo,
      title: 'Welcome to Point Plus Merchant',
      body:
          'Get rewarded for your loyalty. Earn points at all your favourite places.',
    ),
    (
      image: AppAssets.dashboardFirst,
      title: 'Promote your Shop to your Locality.',
      body: 'Promote your shop to your locality and grow!',
    ),
    (
      image: AppAssets.dashboradSecond,
      title: 'Grow your Business Exponentially!',
      body: 'Pay less on each transaction you make with our app',
    ),
  ];

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      _currentPage = (_currentPage + 1) % _carouselItems.length;

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
    super.initState();
    _startSplash();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? SplashPage()
        : Scaffold(
            body: Padding(
              padding: AppSpacing.defaultPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: AppSpacing.defaultSpacing,
                children: [
                  Expanded(
                    flex: 8,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          _currentPage = value;
                        });
                      },
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        final item = _carouselItems[index];
                        return CarouselWidget(
                          image: item.image,
                          title: item.title,
                          body: item.body,
                        );
                      },
                      itemCount: _carouselItems.length,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: _carouselItems.length,
                          effect: ExpandingDotsEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.defaultSpacing + 16),
                        GradientElevatedButton(
                          onPressed: () => context.pushNamed(AppRoutes.logIn),
                          text: 'Login',
                          isDisabled: false,
                        ),
                      ],
                    ),
                  ).animate().fade(delay: 1000.ms, duration: 1000.ms),
                ],
              ),
            ),
          );
  }
}
