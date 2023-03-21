part of 'bus_type_bloc.dart';

@immutable
abstract class BusTypeEvent {}

class BusTypeGetEvent extends BusTypeEvent {}

class BusTypeAddEvent extends BusTypeEvent {
  int id;
  String type;
  int range;

  BusTypeAddEvent(this.id, this.type, this.range);
}

class  BusTypeDeleteEvent extends BusTypeEvent {
  final BusType busType;

  BusTypeDeleteEvent(this.busType);
}
