part of 'direction_bloc.dart';

@immutable
abstract class DirectionEvent {}

class DirectionGetEvent extends DirectionEvent {}

class DirectionAddEvent extends DirectionEvent {
  final int studentId;
  final int directionId;

  DirectionAddEvent(this.studentId, this.directionId);
}