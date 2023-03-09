part of 'subject_bloc.dart';

@immutable
abstract class SubjectState {}

class SubjectInitial extends SubjectState {}

class SubjectLoadingState extends SubjectState {}

class SubjectLoadedState extends SubjectState {
  final List<Subject> subjectList;

  SubjectLoadedState(this.subjectList);
}

class SubjectErrorState extends SubjectState {
  final String error;

  SubjectErrorState(this.error);
}
