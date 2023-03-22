part of 'road_bloc.dart';

@immutable
abstract class RoadState {}

class RoadInitial extends RoadState {}

class RoadLoadingState extends RoadState {}

class RoadLoadedState extends RoadState {
  final List<City> cityList;
  final List<Road> roadList;

  RoadLoadedState(this.cityList, this.roadList);
}

class RoadErrorState extends RoadState {
  final String error;

  RoadErrorState(this.error);
}
