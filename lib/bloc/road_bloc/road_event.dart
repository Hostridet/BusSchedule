part of 'road_bloc.dart';

@immutable
abstract class RoadEvent {}

class GetRoadEvent extends RoadEvent {}

class AddRoadEvent extends RoadEvent {
  final String startCity;
  final String endCity;

  AddRoadEvent(this.startCity, this.endCity);
}

class DeleteRoadEvent extends RoadEvent {
  final Road road;

  DeleteRoadEvent(this.road);
}
