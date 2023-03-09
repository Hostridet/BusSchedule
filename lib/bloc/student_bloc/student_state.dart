part of 'student_bloc.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoadingState extends StudentState {}

class StudentLoadedState extends StudentState {
  final List<Student> studentList;
  final List<Subject> subjectList;

  StudentLoadedState(this.studentList, this.subjectList);
}

class StudentErrorState extends StudentState {
  final String error;

  StudentErrorState(this.error);
}
