part of 'bus_bloc.dart';

@immutable
abstract class BusEvent {}

class GetBusEvent extends BusEvent {}

class AddBusEvent extends BusEvent {
  final String number;
  final String busType;

  AddBusEvent(this.number, this.busType);
}

class DeleteBusEvent extends BusEvent {
  final Bus bus;

  DeleteBusEvent(this.bus);
}
