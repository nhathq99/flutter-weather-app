import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_weather_app/utils/storage_util.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> initial() async {
    final firstLaunch = await StorageUtil.isFirstLaunch();
    if (!firstLaunch) {
      await StorageUtil.deleteAllSecure();
      StorageUtil.storeFirstLaunch(true);
      await Future<dynamic>.delayed(const Duration(seconds: 1));
      emit(SplashNavigateToOnBoarding());
      return;
    }

    final isHideOnboarding = await StorageUtil.isHideOnboarding();
    if (!isHideOnboarding) {
      await Future<dynamic>.delayed(const Duration(seconds: 1));
      emit(SplashNavigateToOnBoarding());
      return;
    }

    await Future<dynamic>.delayed(const Duration(seconds: 1));
    emit(SplashNavigateToHome());
  }
}
