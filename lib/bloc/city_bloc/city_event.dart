part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class GetCityEvent extends CityEvent {}

class AddCityEvent extends CityEvent {
  final int id;
  final String name;

  AddCityEvent(this.id, this.name);
}

class DeleteCityEvent extends CityEvent {
  final City city;

  DeleteCityEvent(this.city);
}
