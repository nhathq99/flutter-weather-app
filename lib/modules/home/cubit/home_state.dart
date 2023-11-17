part of 'home_cubit.dart';

enum DataStatus {initial, loading, success, failure, failurePopup}

class HomeState extends Equatable {
  const HomeState({
    this.list = const [],
    this.selectedUnit = 0,
    this.status = DataStatus.initial,
    this.error,
  });

  final List<WeatherData> list;
  final int selectedUnit;
  final DataStatus status;
  final Exception? error;

  HomeState copyWith({
    List<WeatherData>? list,
    int? selectedUnit,
    DataStatus? status,
    Exception? error,
  }) {
    return HomeState(
      list: list ?? this.list,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [list, selectedUnit, status, error];
}
