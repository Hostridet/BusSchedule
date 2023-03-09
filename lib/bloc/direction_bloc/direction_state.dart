part of 'direction_bloc.dart';

@immutable
abstract class DirectionState {}

class DirectionInitial extends DirectionState {}

class DirectionLoadingState extends DirectionState {}

class DirectionLoadedState extends DirectionState {
  final List<Direction> directionList;
  final List<ReceivedStudent> receivedStudent;

  DirectionLoadedState(this.directionList, this.receivedStudent);
}

class DirectionErrorState extends DirectionState {
  final String error;

  DirectionErrorState(this.error);
}
