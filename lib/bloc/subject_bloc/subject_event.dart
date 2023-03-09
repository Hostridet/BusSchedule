part of 'subject_bloc.dart';

@immutable
abstract class SubjectEvent {}

class SubjectGetEvent extends SubjectEvent {}

class SubjectAddEvent extends SubjectEvent {
  final String name;

  SubjectAddEvent(this.name);
}

class SubjectDeleteEvent extends SubjectEvent {
  final int id;

  SubjectDeleteEvent(this.id);
}
