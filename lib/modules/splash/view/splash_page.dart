import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/base/base_state.dart';
import 'package:flutter_weather_app/constants/assets_path.dart';
import 'package:flutter_weather_app/modules/splash/splash.dart';
import 'package:flutter_weather_app/utils/image_util.dart';
import 'package:flutter_weather_app/utils/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => SplashCubit(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> {
  @override
  void initState() {
    context.read<SplashCubit>().initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (ctx, state) {
          if (state is SplashNavigateToOnBoarding) {
            navigate(Routes.onboardingPage, isReplace: true);
          }
          if (state is SplashNavigateToHome) {
            navigate(Routes.homePage, isReplace: true);
          }
        },
        builder: (ctx, state) {
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     AppColors.turquoise,
          //     AppColors.blueStone,
          //   ],
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          // ),
          ),
      child: Center(
        child: ImageUtil.loadAssetsImage(
          width: 200,
          height: 200,
          assetPath: AssetsPath.icLogo,
        ),
      ),
    );
  }
}
