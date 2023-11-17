import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_weather_app/utils/storage_util.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void onStartPressed() {
    StorageUtil.storeOnboarding(true);
    emit(OnboardingNavigateToHome());
  }
}
