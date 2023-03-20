part of 'bus_bloc.dart';

@immutable
abstract class BusState {}

class BusInitial extends BusState {}

class BusLoadingState extends BusState{}

class BusLoadedState extends BusState {
  List<Bus> busList;
  List<BusType> busTypeList;

  BusLoadedState(this.busList, this.busTypeList);
}

class BusErrorState extends BusState {
  final String error;

  BusErrorState(this.error);
}
