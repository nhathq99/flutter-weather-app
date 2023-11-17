import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_weather_app/base/base_state.dart';
import 'package:flutter_weather_app/constants/app_colors.dart';
import 'package:flutter_weather_app/constants/app_constants.dart';
import 'package:flutter_weather_app/constants/assets_path.dart';
import 'package:flutter_weather_app/l10n/l10n.dart';
import 'package:flutter_weather_app/modules/onboarding/onboarding.dart';
import 'package:flutter_weather_app/utils/routes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => OnboardingCubit(),
      child: const OnBoardingView(),
    );
  }
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends BaseState<OnBoardingView> {
  final _pageController = PageController(viewportFraction: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingNavigateToHome) {
          navigate(Routes.homePage, isReplace: true);
        }
      },
      builder: (context, state) {
        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    final pages = _listPage;
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: pages.length,
              controller: _pageController,
              padEnds: false,
              itemBuilder: (context, index) {
                return OnboardingTab(
                  data: pages[index],
                  onButtonPressed: (index == pages.length - 1)
                      ? context.read<OnboardingCubit>().onStartPressed
                      : () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: AppConstants.defaultPadding,
                ),
                child: SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: pages.length,
                  effect: const ExpandingDotsEffect(
                    offset: AppConstants.defaultPadding / 2,
                    dotWidth: AppConstants.defaultPadding / 2,
                    dotHeight: AppConstants.defaultPadding / 2,
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.dark3,
                  ),
                  // your preferred effect
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<OnboardingData> get _listPage => [
        OnboardingData(
          isFirstPage: true,
          isLastPage: false,
          img: AssetsPath.icDay,
          desc: context.l10n.onboarding1,
          btnText: context.l10n.next,
        ),
        OnboardingData(
          isFirstPage: false,
          isLastPage: true,
          img: AssetsPath.icNight,
          desc: context.l10n.onboarding2,
          btnText: context.l10n.startNow,
        ),
      ];
}
