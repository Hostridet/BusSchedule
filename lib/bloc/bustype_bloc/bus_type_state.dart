part of 'bus_type_bloc.dart';

@immutable
abstract class BusTypeState {}

class BusTypeInitial extends BusTypeState {}

class BusTypeLoadingState extends BusTypeState {}

class BusTypeLoadedState extends BusTypeState {
   final List<BusType> listBusType;

   BusTypeLoadedState(this.listBusType);
}

class BusTypeErrorState extends BusTypeState {
   final String error;

   BusTypeErrorState(this.error);
}


