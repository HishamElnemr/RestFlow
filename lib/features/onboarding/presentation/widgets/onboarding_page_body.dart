import 'package:flutter/material.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/restflow_logo.dart';
import '../../data/models/onboarding_model.dart';
import '../widgets/onboarding_carousel_item.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/page_indicator.dart';

class OnboardingPageBody extends StatefulWidget {
  const OnboardingPageBody({super.key});

  @override
  State<OnboardingPageBody> createState() => _OnboardingPageBodyState();
}

class _OnboardingPageBodyState extends State<OnboardingPageBody> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _pages = const [
    OnboardingModel(
      title: 'AI-Powered Insights',
      description:
          'Get intelligent recommendations and forecasts to optimize your restaurant operations and boost revenue',
      imagePath: 'assets/images/onboarding1.svg',
      gradient: AppColors.purpleDiagonalGradient,
    ),
    OnboardingModel(
      title: 'Streamlined Order Management',
      description:
          'Manage dine-in, takeaway, and delivery orders from one unified platform with real-time status tracking',
      imagePath: 'assets/images/onboarding2.svg',
      gradient: AppColors.electricBlueGradient,
    ),
    OnboardingModel(
      title: 'Smart Inventory Alerts',
      description:
          'Never run out of ingredients with automated low-stock alerts and inventory depletion forecasts',
      imagePath: 'assets/images/onboarding3.svg',
      gradient: AppColors.orangeGradient,
    ),
  ];

  void _onNextPressed() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onSkipPressed();
    }
  }

  void _onBackPressed() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkipPressed() {
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        children: [
          const Spacer(),
          const RestflowLogo(),
          const SizedBox(height: 45),
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: OnboardingCarouselItem(
                    title: _pages[index].title,
                    description: _pages[index].description,
                    imagePath: _pages[index].imagePath,
                    gradient: _pages[index].gradient,
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          PageIndicator(
            count: _pages.length,
            currentIndex: _currentIndex,
          ),
          const SizedBox(height: 48),
          OnboardingControls(
            currentIndex: _currentIndex,
            onNextPressed: _onNextPressed,
            onBackPressed: _onBackPressed,
            onSkipPressed: _onSkipPressed,
          ),
        ],
      ),
    );
  }
}
