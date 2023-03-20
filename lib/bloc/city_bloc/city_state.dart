part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class CityInitial extends CityState {}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  final List<City> cityList;

  CityLoadedState(this.cityList);
}

class CityErrorState extends CityState {
  final String error;

  CityErrorState(this.error);
}
